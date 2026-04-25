//
//  Models.swift
//  MillionaireGame
//

import Foundation

struct PlayerProfile {
    let firstName: String
    let lastName: String
    let email: String
    let dateOfBirth: Date

    var displayName: String {
        "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
    }
}

struct GameQuestion: Identifiable {
    let id = UUID()
    let text: String
    let options: [String]
    let correctAnswer: String
    let genre: String
}

enum GameOutcome: Equatable {
    case completed
    case incorrectAnswer(selected: String, correct: String)
    case timedOut(correct: String)

    var message: String {
        switch self {
        case .completed:
            return "You cleared every question in the ladder."
        case let .incorrectAnswer(selected, correct):
            return "\"\(selected)\" was not correct. The right answer was \"\(correct)\"."
        case let .timedOut(correct):
            return "Time ran out. The correct answer was \"\(correct)\"."
        }
    }
}
