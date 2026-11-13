import XCTest
@testable import MillionaireGame

final class MillionaireGameTests: XCTestCase {
    func testRegistrationValidationAcceptsCompleteInput() {
        XCTAssertTrue(
            GameRules.isValidRegistration(
                firstName: "Amartya",
                lastName: "Karmakar",
                email: "amartya@example.com"
            )
        )
    }

    func testRegistrationValidationRejectsMissingFields() {
        XCTAssertFalse(
            GameRules.isValidRegistration(
                firstName: "",
                lastName: "Karmakar",
                email: "amartya@example.com"
            )
        )
        XCTAssertFalse(
            GameRules.isValidRegistration(
                firstName: "Amartya",
                lastName: "Karmakar",
                email: "invalid-email"
            )
        )
    }

    func testDelayedTimerUpdatesUseElapsedTimeInsteadOfTickCount() {
        let start = ContinuousClock().now
        let timer = QuestionTimer(questionIndex: 0, now: start)
        XCTAssertEqual(timer.remaining(at: start), 120)
        XCTAssertEqual(timer.remaining(at: start.advanced(by: .seconds(12))), 108)
        // Repeated callbacks at the same instant must not consume extra seconds.
        XCTAssertEqual(timer.remaining(at: start.advanced(by: .seconds(12))), 108)
        XCTAssertEqual(timer.remaining(at: start.advanced(by: .seconds(119.5))), 1)
        XCTAssertEqual(timer.remaining(at: start.advanced(by: .seconds(120))), 0)
        XCTAssertEqual(timer.remaining(at: start.advanced(by: .seconds(600))), 0)
    }

    func testEachQuestionGetsItsOwnDeadlineAtEveryTimerTier() {
        let start = ContinuousClock().now
        for (index, duration) in [(0, 120), (5, 60), (10, 30)] {
            let timer = QuestionTimer(questionIndex: index, now: start)
            XCTAssertEqual(timer.remaining(at: start), duration)
            XCTAssertEqual(timer.remaining(at: start.advanced(by: .seconds(Double(duration)))), 0)
            let nextStart = start.advanced(by: .seconds(600))
            let restarted = QuestionTimer(questionIndex: index, now: nextStart)
            XCTAssertEqual(restarted.remaining(at: nextStart), duration)
        }
    }

    func testContinuousDeadlineRoundsPositiveFractionsAndExpiresExactly() {
        let start = ContinuousClock().now
        let timer = QuestionTimer(questionIndex: 10, now: start)
        XCTAssertEqual(timer.remaining(at: start.advanced(by: .nanoseconds(1))), 30)
        XCTAssertEqual(timer.remaining(at: start.advanced(by: .seconds(29))), 1)
        XCTAssertEqual(timer.remaining(at: timer.deadline.advanced(by: .nanoseconds(-1))), 1)
        XCTAssertEqual(timer.remaining(at: timer.deadline), 0)
        XCTAssertEqual(timer.remaining(at: timer.deadline.advanced(by: .nanoseconds(1))), 0)
    }

    func testQueuedAnswerCannotApplyToTheNextQuestion() {
        let first = GameQuestion(text: "First", options: ["A", "B"], correctAnswer: "A", genre: "Test")
        let next = GameQuestion(text: "Next", options: ["A", "B"], correctAnswer: "B", genre: "Test")
        XCTAssertTrue(GameRules.canAcceptAnswer("A", for: first.id, currentQuestion: first, visibleOptions: first.options))
        // Even shared answer text must not let a queued tap from the first question end the next one.
        XCTAssertFalse(GameRules.canAcceptAnswer("A", for: first.id, currentQuestion: next, visibleOptions: next.options))
        XCTAssertTrue(GameRules.canAcceptAnswer("B", for: next.id, currentQuestion: next, visibleOptions: next.options))
        XCTAssertFalse(GameRules.canAcceptAnswer("A", for: next.id, currentQuestion: next, visibleOptions: ["B"]))
    }

    func testTimeLimitTransitionsAcrossRounds() {
        XCTAssertEqual(GameRules.timeLimit(for: 0), 120)
        XCTAssertEqual(GameRules.timeLimit(for: 4), 120)
        XCTAssertEqual(GameRules.timeLimit(for: 5), 60)
        XCTAssertEqual(GameRules.timeLimit(for: 9), 60)
        XCTAssertEqual(GameRules.timeLimit(for: 10), 30)
        XCTAssertEqual(GameRules.timeLimit(for: 14), 30)
    }

    func testReducedOptionsKeepsCorrectAnswerAndLeavesTwoChoices() {
        let options = ["A", "B", "C", "D"]
        let reduced = GameRules.reducedOptions(from: options, keeping: "C")

        XCTAssertEqual(reduced.count, 2)
        XCTAssertTrue(reduced.contains("C"))
    }

    func testRegistrationRejectsMalformedEmailAddresses() {
        for email in ["@.", "a@@example.com", "a@.com", "a@example.", "a b@example.com", "a@example..com"] {
            XCTAssertFalse(GameRules.isValidRegistration(firstName: "A", lastName: "B", email: email), email)
        }
        XCTAssertTrue(GameRules.isValidRegistration(firstName: "A", lastName: "B", email: "  a+quiz@example.co.uk  "))
    }

    func testHintLeavesTwoChoicesForDifferentOptionCounts() {
        for options in [["A", "B", "C"], ["A", "B", "C", "D", "E"]] {
            let reduced = GameRules.reducedOptions(from: options, keeping: "C")
            XCTAssertEqual(reduced.count, 2)
            XCTAssertTrue(reduced.contains("C"))
            XCTAssertEqual(GameRules.reducedOptions(from: reduced, keeping: "C"), reduced)
        }
        XCTAssertEqual(GameRules.reducedOptions(from: ["A", "B", "C"], keeping: "missing"), ["A", "B", "C"])
    }

    func testQuestionBankSupportsCompleteLaddersAndValidHints() {
        XCTAssertEqual(QuestionBank.prizeLadder.count, 15)
        XCTAssertEqual(QuestionBank.prizeLadder.last, 1_000_000)
        XCTAssertEqual(QuestionBank.prizeLadder, QuestionBank.prizeLadder.sorted())
        for genre in QuestionBank.genres {
            let questions = QuestionBank.questions(for: genre)
            XCTAssertGreaterThanOrEqual(questions.count, QuestionBank.prizeLadder.count)
            XCTAssertEqual(Set(questions.map(\.text)).count, questions.count)
            for question in questions {
                XCTAssertEqual(question.options.count, 4)
                XCTAssertEqual(Set(question.options).count, 4)
                XCTAssertTrue(question.options.contains(question.correctAnswer))
                let reduced = GameRules.reducedOptions(from: question.options, keeping: question.correctAnswer)
                XCTAssertEqual(reduced.count, 2)
                XCTAssertTrue(reduced.contains(question.correctAnswer))
            }
        }
    }

    func testQuestionBankProvidesQuestionsForEachGenre() {
        for genre in QuestionBank.genres {
            XCTAssertFalse(QuestionBank.questions(for: genre).isEmpty, "Expected questions for genre \(genre)")
        }
    }
}

final class GameSessionTests: XCTestCase {
    private let start = ContinuousClock().now

    private func newRun() -> GameSession {
        GameSession(questions: QuestionBank.questions(for: QuestionBank.genres[0]))
    }

    private func advance(_ game: inout GameSession, count: Int, at now: ContinuousClock.Instant) {
        for _ in 0..<count {
            guard let question = game.currentQuestion else { return XCTFail("Missing question") }
            game.answer(question.correctAnswer, for: question.id, at: now)
        }
    }

    func testFullMillionRunForEveryGenre() {
        for genre in QuestionBank.genres {
            var game = GameSession(questions: QuestionBank.questions(for: genre))
            game.appear(at: start)
            for index in 0..<15 {
                XCTAssertEqual(game.currentQuestionIndex, index)
                XCTAssertEqual(game.questionsAnswered, index)
                XCTAssertEqual(game.timeRemaining, GameRules.timeLimit(for: index))
                XCTAssertEqual(Set(game.visibleOptions), Set(game.currentQuestion!.options))
                advance(&game, count: 1, at: start)
                XCTAssertEqual(game.winnings, QuestionBank.prizeLadder[index])
            }
            XCTAssertEqual(game.outcome, .completed, genre)
            XCTAssertEqual(game.questionsAnswered, 15)
            XCTAssertEqual(game.winnings, 1_000_000)
            game.refresh(at: start.advanced(by: .seconds(10_000)))
            game.useHint(for: game.currentQuestion!.id, at: start)
            XCTAssertEqual(game.outcome, .completed)
            XCTAssertEqual(game.hintsRemaining, 3)
        }
    }

    func testWrongAnswerAtEveryStepKeepsLastEarnedPrizeAndLocksRun() {
        for index in 0..<15 {
            var game = newRun()
            game.appear(at: start)
            advance(&game, count: index, at: start)
            let question = game.currentQuestion!
            let wrong = question.options.first { $0 != question.correctAnswer }!
            game.answer(wrong, for: question.id, at: start)
            let outcome = GameOutcome.incorrectAnswer(selected: wrong, correct: question.correctAnswer)
            XCTAssertEqual(game.outcome, outcome)
            XCTAssertEqual(game.questionsAnswered, index)
            XCTAssertEqual(game.winnings, index == 0 ? 0 : QuestionBank.prizeLadder[index - 1])
            game.answer(question.correctAnswer, for: question.id, at: start)
            game.useHint(for: game.currentQuestion!.id, at: start)
            game.appear(at: start.advanced(by: .seconds(1_000)))
            XCTAssertEqual(game.outcome, outcome)
            XCTAssertEqual(game.currentQuestionIndex, index)
            XCTAssertEqual(game.hintsRemaining, 3)
        }
    }

    func testBackgroundExpiryAtEveryStepKeepsPrizeAndCorrectCount() {
        for index in 0..<15 {
            var game = newRun()
            game.appear(at: start)
            advance(&game, count: index, at: start)
            let question = game.currentQuestion!
            // No publisher callbacks occur while backgrounded.
            game.appear(at: start.advanced(by: .seconds(600)))
            XCTAssertEqual(game.timeRemaining, 0)
            XCTAssertEqual(game.outcome, .timedOut(correct: question.correctAnswer))
            XCTAssertEqual(game.questionsAnswered, index)
            XCTAssertEqual(game.winnings, index == 0 ? 0 : QuestionBank.prizeLadder[index - 1])
        }
    }

    func testShortBackgroundAndRepeatedAppearDoNotRestartDeadline() {
        var game = newRun()
        game.appear(at: start)
        game.appear(at: start.advanced(by: .seconds(50)))
        XCTAssertEqual(game.timeRemaining, 70)
        game.refresh(at: start.advanced(by: .seconds(50)))
        XCTAssertEqual(game.timeRemaining, 70)
        game.appear(at: start.advanced(by: .seconds(119.5)))
        XCTAssertEqual(game.timeRemaining, 1)
        XCTAssertNil(game.outcome)
        game.refresh(at: start.advanced(by: .seconds(120)))
        XCTAssertNotNil(game.outcome)
    }

    func testExpiredAnswerCannotAwardPrizeBeforeNextPublisherTick() {
        var game = newRun()
        game.appear(at: start)
        let question = game.currentQuestion!
        game.answer(question.correctAnswer, for: question.id, at: start.advanced(by: .seconds(120)))
        XCTAssertEqual(game.outcome, .timedOut(correct: question.correctAnswer))
        XCTAssertEqual(game.winnings, 0)
        XCTAssertEqual(game.questionsAnswered, 0)
    }

    func testExpiredHintCannotConsumeBudgetBeforeNextPublisherTick() {
        var game = newRun()
        game.appear(at: start)
        let options = game.visibleOptions
        game.useHint(for: game.currentQuestion!.id, at: start.advanced(by: .seconds(120)))
        XCTAssertEqual(game.outcome, .timedOut(correct: game.currentQuestion!.correctAnswer))
        XCTAssertEqual(game.hintsRemaining, 3)
        XCTAssertEqual(game.visibleOptions, options)
    }

    func testHintsKeepCorrectOptionAndCanOnlyBeSpentOncePerQuestion() {
        var game = newRun()
        game.appear(at: start)
        for remaining in [2, 1, 0] {
            let question = game.currentQuestion!
            game.useHint(for: game.currentQuestion!.id, at: start)
            XCTAssertEqual(game.visibleOptions.count, 2)
            XCTAssertTrue(game.visibleOptions.contains(question.correctAnswer))
            XCTAssertEqual(game.hintsRemaining, remaining)
            game.useHint(for: game.currentQuestion!.id, at: start)
            XCTAssertEqual(game.hintsRemaining, remaining)
            game.answer(question.correctAnswer, for: question.id, at: start)
            XCTAssertEqual(game.visibleOptions.count, 4)
        }
        game.useHint(for: game.currentQuestion!.id, at: start)
        XCTAssertEqual(game.visibleOptions.count, 4)
        XCTAssertEqual(game.hintsRemaining, 0)
    }

    func testStaleOrRemovedAnswersDoNotChangeScoreOrEndRun() {
        var game = newRun()
        game.appear(at: start)
        let first = game.currentQuestion!
        game.useHint(for: game.currentQuestion!.id, at: start)
        let removed = first.options.first { !game.visibleOptions.contains($0) }!
        game.answer(removed, for: first.id, at: start)
        XCTAssertEqual(game.winnings, 0)
        XCTAssertNil(game.outcome)
        game.answer(first.correctAnswer, for: first.id, at: start)
        game.answer(first.correctAnswer, for: first.id, at: start)
        XCTAssertEqual(game.currentQuestionIndex, 1)
        XCTAssertEqual(game.winnings, QuestionBank.prizeLadder[0])
        XCTAssertNil(game.outcome)
    }

    func testQueuedHintCannotSpendBudgetOnNextQuestion() {
        var game = newRun()
        game.appear(at: start)
        let first = game.currentQuestion!
        game.answer(first.correctAnswer, for: first.id, at: start)
        let options = game.visibleOptions
        game.useHint(for: first.id, at: start)
        XCTAssertEqual(game.hintsRemaining, 3)
        XCTAssertEqual(game.visibleOptions, options)
        let current = game.currentQuestion!
        game.useHint(for: current.id, at: start)
        XCTAssertEqual(game.hintsRemaining, 2)
        XCTAssertEqual(game.visibleOptions.count, 2)
        XCTAssertTrue(game.visibleOptions.contains(current.correctAnswer))
    }

    func testReplayStartsFreshWithNewDeadlineAndHintBudget() {
        var game = newRun()
        game.appear(at: start)
        game.useHint(for: game.currentQuestion!.id, at: start)
        advance(&game, count: 4, at: start)
        game.refresh(at: start.advanced(by: .seconds(600)))
        game = newRun() // Same reset operation used by GameView.
        let restart = start.advanced(by: .seconds(1_000))
        game.appear(at: restart)
        XCTAssertEqual(game.winnings, 0)
        XCTAssertEqual(game.questionsAnswered, 0)
        XCTAssertEqual(game.hintsRemaining, 3)
        XCTAssertEqual(game.visibleOptions.count, 4)
        XCTAssertEqual(game.timeRemaining, 120)
        XCTAssertNil(game.outcome)
        game.refresh(at: restart.advanced(by: .seconds(1)))
        XCTAssertEqual(game.timeRemaining, 119)
    }

    func testEmptyAndNotYetPresentedRunsCannotBePlayed() {
        var empty = GameSession(questions: [])
        empty.appear(at: start)
        empty.refresh(at: start)
        empty.useHint(for: UUID(), at: start)
        XCTAssertNil(empty.currentQuestion)
        XCTAssertNil(empty.outcome)
        var game = newRun()
        let question = game.currentQuestion!
        game.answer(question.correctAnswer, for: question.id, at: start)
        game.useHint(for: game.currentQuestion!.id, at: start)
        XCTAssertEqual(game.winnings, 0)
        XCTAssertEqual(game.hintsRemaining, 3)
    }
}
