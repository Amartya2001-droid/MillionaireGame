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

/// Game transitions are shared by SwiftUI and deterministic lifecycle/gameplay tests.
struct GameSession {
    let questions: [GameQuestion]
    private(set) var currentQuestionIndex = 0
    private(set) var visibleOptions: [String]
    private(set) var hintsRemaining = 3
    private(set) var timeRemaining = GameRules.timeLimit(for: 0)
    private(set) var winnings = 0
    private(set) var outcome: GameOutcome?
    private var questionTimer: QuestionTimer?

    init(questions: [GameQuestion]) {
        self.questions = Array(questions.prefix(QuestionBank.prizeLadder.count))
        visibleOptions = self.questions.first?.options.shuffled() ?? []
    }

    var currentQuestion: GameQuestion? {
        questions.indices.contains(currentQuestionIndex) ? questions[currentQuestionIndex] : nil
    }

    var questionsAnswered: Int {
        outcome == .completed ? questions.count : currentQuestionIndex
    }

    // Reappearing/foregrounding never restarts an existing deadline.
    mutating func appear(at now: ContinuousClock.Instant) {
        guard currentQuestion != nil, outcome == nil else { return }
        if questionTimer == nil { startQuestion(at: now) }
        refresh(at: now)
    }

    mutating func refresh(at now: ContinuousClock.Instant) {
        guard outcome == nil, let question = currentQuestion, let questionTimer else { return }
        timeRemaining = questionTimer.remaining(at: now)
        if timeRemaining == 0 { outcome = .timedOut(correct: question.correctAnswer) }
    }

    mutating func answer(_ option: String, for questionID: UUID, at now: ContinuousClock.Instant) {
        refresh(at: now)
        guard outcome == nil, questionTimer != nil, let question = currentQuestion,
              GameRules.canAcceptAnswer(option, for: questionID,
                                        currentQuestion: question, visibleOptions: visibleOptions) else { return }
        guard option == question.correctAnswer else {
            outcome = .incorrectAnswer(selected: option, correct: question.correctAnswer)
            return
        }
        winnings = QuestionBank.prizeLadder[currentQuestionIndex]
        if currentQuestionIndex == questions.count - 1 {
            outcome = .completed
        } else {
            currentQuestionIndex += 1
            startQuestion(at: now)
            visibleOptions = currentQuestion?.options.shuffled() ?? []
        }
    }

    mutating func useHint(for questionID: UUID, at now: ContinuousClock.Instant) {
        refresh(at: now)
        guard outcome == nil, questionTimer != nil, let question = currentQuestion,
              questionID == question.id,
              hintsRemaining > 0, visibleOptions.count > 2 else { return }
        visibleOptions = GameRules.reducedOptions(from: visibleOptions.shuffled(), keeping: question.correctAnswer)
        hintsRemaining -= 1
    }

    private mutating func startQuestion(at now: ContinuousClock.Instant) {
        questionTimer = QuestionTimer(questionIndex: currentQuestionIndex, now: now)
        timeRemaining = GameRules.timeLimit(for: currentQuestionIndex)
    }
}
