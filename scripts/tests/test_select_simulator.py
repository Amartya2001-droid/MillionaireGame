import unittest
from scripts.select_simulator import select_simulator


def device(name, udid, available=True, state="Shutdown"):
    return dict(name=name, udid=udid, isAvailable=available, state=state)


class SimulatorSelectionTests(unittest.TestCase):
    def test_selects_installed_iphone_without_requiring_iphone_16(self):
        self.assertEqual(select_simulator({"devices": {
            "com.apple.CoreSimulator.SimRuntime.iOS-26-0": [device("iPhone 17", "new")],
        }}), "new")

    def test_ignores_unavailable_devices_ipads_and_other_platforms(self):
        self.assertEqual(select_simulator({"devices": {
            "com.apple.CoreSimulator.SimRuntime.iOS-26-0": [
                device("iPhone 17", "unavailable", False), device("iPad Pro", "ipad")],
            "com.apple.CoreSimulator.SimRuntime.tvOS-26-0": [device("iPhone", "wrong-platform")],
            "com.apple.CoreSimulator.SimRuntime.iOS-18-5": [device("iPhone 16", "available")],
        }}), "available")

    def test_orders_versions_numerically_and_prefers_booted_on_latest_runtime(self):
        self.assertEqual(select_simulator({"devices": {
            "com.apple.CoreSimulator.SimRuntime.iOS-18-9": [device("iPhone", "old")],
            "com.apple.CoreSimulator.SimRuntime.iOS-18-10": [
                device("iPhone", "shutdown"), device("iPhone", "booted", state="Booted")],
        }}), "booted")

    def test_explains_missing_runtime(self):
        with self.assertRaisesRegex(ValueError, "No available iPhone simulator"):
            select_simulator({"devices": {}})
