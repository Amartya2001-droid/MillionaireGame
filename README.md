# MillionaireGame

MillionaireGame is a SwiftUI iOS quiz app inspired by the tension and pacing of "Who Wants to Be a Millionaire?". The project focuses on clean game flow, polished presentation, timed question rounds, and a simple architecture that is easy to extend.

## Why This Project Stands Out

- Built with SwiftUI and structured into focused source files instead of one large view dump
- Uses a clean navigation flow from landing screen to registration, category selection, gameplay, and results
- Includes time-based rounds, a prize ladder, persistent best-score tracking, and 50:50 hints
- Keeps quiz data separate from view code so categories and questions are easy to expand
- Designed to read well on GitHub as a real project, not just a classroom submission

## Tech Stack

- Swift
- SwiftUI
- Xcode project setup for iOS
- Local app state with `@State` and `@AppStorage`

## App Flow

1. Open the app from the landing screen.
2. Enter player information.
3. Pick one of five quiz genres.
4. Answer 15 questions against the clock.
5. Use up to three 50:50 hints during the run.
6. Finish the ladder and aim for the top prize.

## Project Structure

- `MillionaireGame/ContentView.swift`
  The landing screen and top-level navigation entry point.
- `MillionaireGame/GameFlowViews.swift`
  Registration, genre selection, gameplay, results, and instructions screens.
- `MillionaireGame/Models.swift`
  Core domain models such as player and question types.
- `MillionaireGame/QuestionBank.swift`
  Prize ladder data and the quiz question dataset.
- `MillionaireGame/DesignSystem.swift`
  Shared styling, button styles, background visuals, and helper extensions.
- `MillionaireGame.xcodeproj`
  Xcode project configuration.

## Features

- Home screen with a clear call to action
- Registration flow before gameplay
- Genre-based quiz rounds
- 15-question progression system
- Dynamic countdown timing by round
- 50:50 hint mechanic
- Prize ladder progression
- Results screen with replay flow
- Best-score persistence on device

## Running Locally

### Requirements

- macOS
- Full Xcode installation
- iOS Simulator or Apple device for runtime testing

### Setup

```bash
git clone https://github.com/Amartya2001-droid/MillionaireGame.git
cd MillionaireGame
open MillionaireGame.xcodeproj
```

Then choose a simulator in Xcode and run with `Cmd + R`.

## Notes

- The active app target lives entirely inside the `MillionaireGame/` folder.
- Full simulator verification requires Xcode. Command Line Tools alone are not enough to run `xcodebuild` for this app target.

## Future Improvements

- Add dedicated unit tests for question and timer logic
- Add sound effects and animations for correct and incorrect answers
- Add a richer settings screen
- Introduce accessibility improvements and voice support

## License

No license has been added yet.
