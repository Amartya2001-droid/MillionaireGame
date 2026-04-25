//
//  GameRules.swift
//  MillionaireGame
//

import Foundation

enum GameRules {
    static func isValidRegistration(firstName: String, lastName: String, email: String) -> Bool {
        !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        email.contains("@") &&
        email.contains(".")
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

    static func reducedOptions(from options: [String], keeping correctAnswer: String) -> [String] {
        guard options.count > 2 else { return options }

        let incorrectOptions = options.filter { $0 != correctAnswer }
        let removableOptions = incorrectOptions.prefix(2)
        let removalSet = Set(removableOptions)

        return options.filter { !removalSet.contains($0) }
    }
}
