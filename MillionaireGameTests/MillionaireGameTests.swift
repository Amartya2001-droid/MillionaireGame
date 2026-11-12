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
        let start = Date(timeIntervalSince1970: 1_000)
        let timer = QuestionTimer(questionIndex: 0, now: start)
        XCTAssertEqual(timer.remaining(at: start), 120)
        XCTAssertEqual(timer.remaining(at: start.addingTimeInterval(12)), 108)
        // Repeated callbacks at the same instant must not consume extra seconds.
        XCTAssertEqual(timer.remaining(at: start.addingTimeInterval(12)), 108)
        XCTAssertEqual(timer.remaining(at: start.addingTimeInterval(119.5)), 1)
        XCTAssertEqual(timer.remaining(at: start.addingTimeInterval(120)), 0)
        XCTAssertEqual(timer.remaining(at: start.addingTimeInterval(600)), 0)
    }

    func testEachQuestionGetsItsOwnDeadlineAtEveryTimerTier() {
        let start = Date(timeIntervalSince1970: 1_000)
        for (index, duration) in [(0, 120), (5, 60), (10, 30)] {
            let timer = QuestionTimer(questionIndex: index, now: start)
            XCTAssertEqual(timer.remaining(at: start), duration)
            XCTAssertEqual(timer.remaining(at: start.addingTimeInterval(Double(duration))), 0)
            let nextStart = start.addingTimeInterval(600)
            let restarted = QuestionTimer(questionIndex: index, now: nextStart)
            XCTAssertEqual(restarted.remaining(at: nextStart), duration)
        }
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
