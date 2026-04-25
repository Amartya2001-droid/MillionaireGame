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

    func testQuestionBankProvidesQuestionsForEachGenre() {
        for genre in QuestionBank.genres {
            XCTAssertFalse(QuestionBank.questions(for: genre).isEmpty, "Expected questions for genre \(genre)")
        }
    }
}
