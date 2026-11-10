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
