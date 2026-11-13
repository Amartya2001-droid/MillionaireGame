"""Select an installed, available iPhone simulator for the active Xcode."""
import json
import re
import subprocess


def select_simulator(payload):
    candidates = []
    for runtime, devices in payload.get("devices", {}).items():
        match = re.search(r"SimRuntime\.iOS-([0-9-]+)$", runtime)
        if not match:
            continue
        version = tuple(int(part) for part in match.group(1).split("-"))
        for device in devices:
            if device.get("isAvailable") and device.get("name", "").startswith("iPhone"):
                candidates.append((version, device.get("state") == "Booted", device["udid"]))
    if not candidates:
        raise ValueError("No available iPhone simulator for the selected Xcode; install an iOS runtime.")
    return max(candidates)[2]


if __name__ == "__main__":
    payload = json.loads(subprocess.check_output(
        ["xcrun", "simctl", "list", "devices", "available", "--json"], text=True))
    print("IOS_SIMULATOR_UDID=" + select_simulator(payload))
