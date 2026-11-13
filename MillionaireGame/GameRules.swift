//
//  GameRules.swift
//  MillionaireGame
//

import Foundation

enum GameRules {
    static func isValidRegistration(firstName: String, lastName: String, email: String) -> Bool {
        guard !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return false }

        let address = email.trimmingCharacters(in: .whitespacesAndNewlines)
        guard address.rangeOfCharacter(from: .whitespacesAndNewlines) == nil else { return false }
        let parts = address.split(separator: "@", omittingEmptySubsequences: false)
        guard parts.count == 2, !parts[0].isEmpty,
              !parts[0].hasPrefix("."), !parts[0].hasSuffix("."),
              !parts[0].contains("..") else { return false }

        let labels = parts[1].split(separator: ".", omittingEmptySubsequences: false)
        return labels.count >= 2 && labels.allSatisfy { label in
            !label.isEmpty && !label.hasPrefix("-") && !label.hasSuffix("-") &&
            label.allSatisfy { $0.isASCII && ($0.isLetter || $0.isNumber || $0 == "-") }
        }
    }

    static func validationMessage(isValid: Bool) -> String {
        isValid
            ? "You can update these details any time before starting a run."
            : "Enter your full name and a valid email address to continue."
    }

    static func timeLimit(for questionIndex: Int) -> Int {
        switch questionIndex {
        case 0..<5:
            return 120
        case 5..<10:
            return 60
        default:
            return 30
        }
    }

    static func canAcceptAnswer(_ option: String, for questionID: UUID,
                                currentQuestion: GameQuestion, visibleOptions: [String]) -> Bool {
        questionID == currentQuestion.id && visibleOptions.contains(option)
    }

    static func reducedOptions(from options: [String], keeping correctAnswer: String) -> [String] {
        guard options.count > 2, options.contains(correctAnswer),
              let incorrectAnswer = options.first(where: { $0 != correctAnswer }) else { return options }

        // Preserve display order while retaining one correct and one wrong choice.
        return options.filter { $0 == correctAnswer || $0 == incorrectAnswer }
    }
}

/// Continuous time advances through suspension/sleep without following wall-clock changes.
struct QuestionTimer {
    let deadline: ContinuousClock.Instant

    init(questionIndex: Int, now: ContinuousClock.Instant) {
        deadline = now.advanced(by: .seconds(GameRules.timeLimit(for: questionIndex)))
    }

    func remaining(at now: ContinuousClock.Instant) -> Int {
        let remaining = now.duration(to: deadline)
        guard remaining > .zero else { return 0 }
        let parts = remaining.components
        return Int(parts.seconds) + (parts.attoseconds > 0 ? 1 : 0)
    }
}
