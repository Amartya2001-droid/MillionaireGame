# MillionaireGame

`MillionaireGame` is a SwiftUI iOS quiz app inspired by the "Who Wants to Be a Millionaire?" format. Players register, choose a genre, answer timed questions, use limited hints, and try to climb the prize ladder.

## Features

- SwiftUI-based iOS interface
- Genre-based quiz rounds
- 15-question game flow
- Countdown timer with faster later rounds
- 50:50 hint support
- Prize ladder and results screen

## Project Structure

- `MillionaireGame.xcodeproj` contains the Xcode project
- `MillionaireGame/` contains the active app target source files and assets
- Root-level duplicate Swift files may exist from earlier iterations of the project

## Requirements

- macOS with full Xcode installed
- iOS Simulator or a physical iPhone/iPad for runtime testing

## Getting Started

1. Clone the repository:

```bash
git clone https://github.com/Amartya2001-droid/MillionaireGame.git
cd MillionaireGame
```

2. Open the project:

```bash
open MillionaireGame.xcodeproj
```

3. In Xcode, choose an iOS Simulator or connected device.

4. Build and run with `Cmd + R`.

## Current Status

- The repository contains the app source and assets needed for the quiz experience.
- Full end-to-end verification requires Xcode, because `xcodebuild` and the iOS Simulator are not available with Command Line Tools alone.

## Gameplay

1. Start from the main menu.
2. Enter player details.
3. Pick a genre.
4. Answer questions before the timer runs out.
5. Use up to three hints during a run.
6. Reach the final question to win the top prize.

## Contributing

Issues and pull requests are welcome.

## License

No license has been added yet.
