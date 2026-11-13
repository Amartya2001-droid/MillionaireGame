# MillionaireGame

[![iOS Build](https://github.com/Amartya2001-droid/MillionaireGame/actions/workflows/ios-build.yml/badge.svg)](https://github.com/Amartya2001-droid/MillionaireGame/actions/workflows/ios-build.yml)

MillionaireGame is a SwiftUI iOS quiz app inspired by "Who Wants to Be a Millionaire?".

## Current status

- Implemented: five genres with 15 questions each, a 15-step prize ladder, three 50:50 hints per run, timed questions, and local best-winnings storage.
- Registration details stay in memory; there is no account service or server leaderboard. Prizes are game scores, not real-money payouts.
- Live URL: **not live yet — blocked by an iOS distribution/release setup**. No App Store or TestFlight URL is recorded in this repository.
- Historical Day 2 baseline: merged main (`9fd9557`) passed the simulator build and iOS unit tests in [iOS Build](https://github.com/Amartya2001-droid/MillionaireGame/actions/runs/42916062697), completed November 10, 2026. This was verified from CI, not built locally on Linux.
- Question timers use wall-clock deadlines: elapsed time continues while the app is backgrounded, and expiry is checked before answers or hints. System clock changes affect these deadlines.
- Linux can run the Foundation logic tests below. It cannot build SwiftUI iOS code or verify simulator UI, device behavior, signing, or distribution; those require macOS/Xcode.

CI selects an available iPhone simulator from the active Xcode installation instead of requiring a particular model name. The merged timer commit (`3d0a0ae`) initially failed CI because the runner had no matching iPhone 16; see [the failed run](https://github.com/Amartya2001-droid/MillionaireGame/actions/runs/43322905782). Check the build badge for the current result.

Each run assigns fresh question identities, including replay with the same bank order. Queued answers and hints from a previous run cannot affect the new run; question text, choices, answers, and genres are unchanged.

## Highlights

- Built with SwiftUI for iOS
- Clean navigation from landing page to registration, genre selection, gameplay, and results
- Time-based progression with a 15-question prize ladder
- 50:50 hint mechanic and local best-score persistence
- Extracted game rules for testable business logic
- GitHub Actions workflow that builds and tests the app on macOS

## Tech Stack

- Swift
- SwiftUI
- XCTest
- Xcode
- GitHub Actions

## Architecture

```mermaid
flowchart TD
    A["ContentView"] --> B["RegistrationView"]
    B --> C["GenreSelectionView"]
    C --> D["GameView"]
    D --> E["ResultsView"]

    D --> F["GameRules"]
    D --> G["QuestionBank"]
    B --> F

    F --> H["Unit Tests"]
    G --> H
```

## Project Structure

- `MillionaireGame/ContentView.swift`
  Entry point for the landing screen and app navigation.
- `MillionaireGame/GameFlowViews.swift`
  Registration, genre selection, gameplay, results, and instructions.
- `MillionaireGame/GameRules.swift`
  Pure game-logic helpers for validation, timing, and hint reduction.
- `MillionaireGame/Models.swift`
  Core domain models such as `PlayerProfile`, `GameQuestion`, and `GameOutcome`.
- `MillionaireGame/QuestionBank.swift`
  Quiz data and prize ladder configuration.
- `MillionaireGame/DesignSystem.swift`
  Shared visual styling, button styles, and UI helpers.
- `MillionaireGameTests/MillionaireGameTests.swift`
  Unit tests for core game logic.
- `.github/workflows/ios-build.yml`
  GitHub Actions workflow for simulator builds and tests.

## Gameplay

1. Start from the home screen.
2. Enter player details.
3. Choose a quiz genre.
4. Answer 15 questions against the clock.
5. Use up to three 50:50 hints strategically.
6. Finish the ladder and aim for the top prize.

## What I Focused On

- Breaking a prototype-style codebase into focused files
- Keeping UI code readable while moving rules into testable logic
- Making the repository presentable and verifiable on GitHub
- Using CI so the project shows build discipline even without local Xcode installed

## Running Locally

### Requirements

- macOS
- Full Xcode installation
- iOS Simulator or physical Apple device

### Setup

```bash
git clone https://github.com/Amartya2001-droid/MillionaireGame.git
cd MillionaireGame
open MillionaireGame.xcodeproj
```

Choose a simulator in Xcode and run with `Cmd + R`.

## Automated Verification

The repository includes a GitHub Actions workflow that:

- Selects Xcode on a macOS runner
- Builds the app for iOS Simulator
- Runs the unit test suite

For portable logic verification with Swift 5.9 or later:

```bash
swift test
```

This runs the same XCTest source against `GameRules`, `Models`, and `QuestionBank`.
`GameView` delegates gameplay to the Foundation `GameSession` model. Automated code-based play-tests cover full million-score runs in all five genres, incorrect answers and background expiry at every ladder step, short background returns, exact-deadline answers/hints, lifeline limits, stale answers and hints, and replay. Hint callbacks are tied to the displayed question, so a queued tap cannot consume a lifeline after progression. These are injected-time model tests; actual background/foreground UI behavior and best-score storage still require simulator/device checks.
It does not build or exercise the SwiftUI screens. Use the macOS workflow for the full app build and hosted iOS tests.

## Future Improvements

- Add richer game audio and motion feedback
- Expand the question bank and difficulty scaling
- Add accessibility improvements and voice guidance
- Add screenshot assets or a demo video for the README

## License

No license has been added yet.
