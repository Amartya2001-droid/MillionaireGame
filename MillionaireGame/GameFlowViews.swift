//
//  GameFlowViews.swift
//  MillionaireGame
//

import SwiftUI

struct RegistrationView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var dateOfBirth = Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()
    @State private var shouldShowGenres = false

    var body: some View {
        ZStack {
            MillionaireBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Player Registration")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)

                    Text("Enter your details to unlock the question ladder.")
                        .foregroundStyle(Color.white.opacity(0.82))

                    inputField(title: "First Name", text: $firstName, capitalization: .words)
                    inputField(title: "Last Name", text: $lastName, capitalization: .words)
                    inputField(
                        title: "Email",
                        text: $email,
                        capitalization: .never,
                        keyboardType: .emailAddress,
                        disableAutocorrection: true
                    )

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Date of Birth")
                            .foregroundStyle(Color.white.opacity(0.8))
                            .font(.subheadline.weight(.medium))

                        DatePicker(
                            "Date of Birth",
                            selection: $dateOfBirth,
                            in: ...Date(),
                            displayedComponents: .date
                        )
                        .labelsHidden()
                        .datePickerStyle(.graphical)
                        .padding(12)
                        .background(Color.white.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .tint(.white)
                        .environment(\.colorScheme, .dark)
                    }

                    NavigationLink(isActive: $shouldShowGenres) {
                        GenreSelectionView(player: playerProfile)
                    } label: {
                        EmptyView()
                    }

                    Button("Continue") {
                        shouldShowGenres = true
                    }
                    .buttonStyle(PrimaryActionButtonStyle())
                    .disabled(!formIsValid)

                    Text(validationMessage)
                        .font(.footnote)
                        .foregroundStyle(formIsValid ? Color.white.opacity(0.75) : Color.red.opacity(0.92))
                }
                .padding(24)
            }
        }
        .navigationTitle("Registration")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var playerProfile: PlayerProfile {
        PlayerProfile(
            firstName: firstName.trimmingCharacters(in: .whitespacesAndNewlines),
            lastName: lastName.trimmingCharacters(in: .whitespacesAndNewlines),
            email: email.trimmingCharacters(in: .whitespacesAndNewlines),
            dateOfBirth: dateOfBirth
        )
    }

    private var formIsValid: Bool {
        GameRules.isValidRegistration(
            firstName: playerProfile.firstName,
            lastName: playerProfile.lastName,
            email: playerProfile.email
        )
    }

    private var validationMessage: String {
        GameRules.validationMessage(isValid: formIsValid)
    }

    private func inputField(
        title: String,
        text: Binding<String>,
        capitalization: TextInputAutocapitalization = .sentences,
        keyboardType: UIKeyboardType = .default,
        disableAutocorrection: Bool = false
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundStyle(Color.white.opacity(0.8))
                .font(.subheadline.weight(.medium))

            TextField(title, text: text)
                .textInputAutocapitalization(capitalization)
                .keyboardType(keyboardType)
                .autocorrectionDisabled(disableAutocorrection)
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(Color.white.opacity(0.12))
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
    }
}

struct GenreSelectionView: View {
    let player: PlayerProfile

    var body: some View {
        ZStack {
            MillionaireBackground()

            VStack(alignment: .leading, spacing: 20) {
                Text("Choose a Genre")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                Text("Welcome, \(player.displayName). Pick the category you want to master.")
                    .foregroundStyle(Color.white.opacity(0.82))

                ForEach(QuestionBank.genres, id: \.self) { genre in
                    NavigationLink {
                        GameView(player: player, genre: genre)
                    } label: {
                        HStack {
                            Text(genre)
                                .font(.headline)

                            Spacer()

                            Image(systemName: "arrow.right.circle.fill")
                                .font(.title3)
                        }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(GenreButtonStyle())
                }

                Spacer()
            }
            .padding(24)
        }
        .navigationTitle("Genres")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GameView: View {
    let player: PlayerProfile
    let genre: String

    @AppStorage("bestWinnings") private var bestWinnings = 0
    @Environment(\.dismiss) private var dismiss

    @State private var questions: [GameQuestion]
    @State private var currentQuestionIndex = 0
    @State private var visibleOptions: [String]
    @State private var hintsRemaining = 3
    @State private var timeRemaining: Int
    @State private var winnings = 0
    @State private var outcome: GameOutcome?

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(player: PlayerProfile, genre: String) {
        self.player = player
        self.genre = genre

        let selectedQuestions = Array(QuestionBank.questions(for: genre).shuffled().prefix(15))
        _questions = State(initialValue: selectedQuestions)
        _visibleOptions = State(initialValue: selectedQuestions.first?.options.shuffled() ?? [])
        _timeRemaining = State(initialValue: GameRules.timeLimit(for: 0))
    }

    var body: some View {
        ZStack {
            MillionaireBackground()

            if let outcome {
                ResultsView(
                    playerName: player.firstName,
                    genre: genre,
                    winnings: winnings,
                    questionsAnswered: questionsAnswered,
                    didWinMillion: outcome == .completed,
                    message: outcome.message,
                    onPlayAgain: resetGame,
                    onChooseGenre: { dismiss() }
                )
            } else if questions.isEmpty {
                ContentUnavailableView("No Questions Available", systemImage: "exclamationmark.triangle", description: Text("This genre does not have enough questions yet."))
                    .foregroundStyle(.white)
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(genre.uppercased())
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(Color.white.opacity(0.7))

                            Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                                .font(.title3.bold())
                                .foregroundStyle(.white)
                        }

                        Spacer()

                        VStack(alignment: .trailing, spacing: 6) {
                            Text("Winnings")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(Color.white.opacity(0.7))

                            Text(winnings.currencyString)
                                .font(.title3.bold())
                                .foregroundStyle(Color.gold)
                        }
                    }

                    HStack(spacing: 12) {
                        infoCapsule(title: "Player", value: player.firstName)
                        infoCapsule(title: "Time", value: timeString)
                        infoCapsule(title: "Hints", value: "\(hintsRemaining)")
                    }

                    VStack(alignment: .leading, spacing: 14) {
                        Text(currentQuestion.text)
                            .font(.title2.weight(.semibold))
                            .foregroundStyle(.white)

                        Text("Next correct answer: \(QuestionBank.prizeLadder[currentQuestionIndex].currencyString)")
                            .foregroundStyle(Color.white.opacity(0.82))
                    }
                    .padding(22)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))

                    VStack(spacing: 12) {
                        ForEach(visibleOptions, id: \.self) { option in
                            Button {
                                handleAnswer(option)
                            } label: {
                                HStack {
                                    Text(option)
                                        .font(.headline)
                                        .multilineTextAlignment(.leading)

                                    Spacer()
                                }
                                .padding(.horizontal, 18)
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(AnswerButtonStyle())
                        }
                    }

                    Button("Use 50:50 Hint") {
                        useHint()
                    }
                    .buttonStyle(PrimaryActionButtonStyle())
                    .disabled(hintsRemaining == 0 || visibleOptions.count <= 2)

                    Spacer(minLength: 0)
                }
                .padding(24)
                .onReceive(timer) { _ in
                    tick()
                }
            }
        }
        .navigationBarBackButtonHidden(outcome != nil)
        .navigationTitle("Game")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var currentQuestion: GameQuestion {
        questions[currentQuestionIndex]
    }

    private var questionsAnswered: Int {
        outcome == .completed ? questions.count : currentQuestionIndex
    }

    private var timeString: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func infoCapsule(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title.uppercased())
                .font(.caption2.weight(.semibold))
                .foregroundStyle(Color.white.opacity(0.7))

            Text(value)
                .font(.headline)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    private func tick() {
        guard outcome == nil else { return }
        guard timeRemaining > 0 else {
            finishGame(with: .timedOut(correct: currentQuestion.correctAnswer))
            return
        }

        timeRemaining -= 1

        if timeRemaining == 0 {
            finishGame(with: .timedOut(correct: currentQuestion.correctAnswer))
        }
    }

    private func handleAnswer(_ option: String) {
        guard outcome == nil else { return }

        if option == currentQuestion.correctAnswer {
            winnings = QuestionBank.prizeLadder[currentQuestionIndex]

            if currentQuestionIndex == questions.count - 1 {
                finishGame(with: .completed)
            } else {
                currentQuestionIndex += 1
                timeRemaining = GameRules.timeLimit(for: currentQuestionIndex)
                visibleOptions = questions[currentQuestionIndex].options.shuffled()
            }
        } else {
            finishGame(with: .incorrectAnswer(selected: option, correct: currentQuestion.correctAnswer))
        }
    }

    private func useHint() {
        guard hintsRemaining > 0 else { return }
        guard visibleOptions.count > 2 else { return }

        visibleOptions = GameRules.reducedOptions(
            from: visibleOptions.shuffled(),
            keeping: currentQuestion.correctAnswer
        )
        hintsRemaining -= 1
    }

    private func finishGame(with newOutcome: GameOutcome) {
        if winnings > bestWinnings {
            bestWinnings = winnings
        }
        outcome = newOutcome
    }

    private func resetGame() {
        let refreshedQuestions = Array(QuestionBank.questions(for: genre).shuffled().prefix(15))
        questions = refreshedQuestions
        currentQuestionIndex = 0
        visibleOptions = refreshedQuestions.first?.options.shuffled() ?? []
        hintsRemaining = 3
        timeRemaining = GameRules.timeLimit(for: 0)
        winnings = 0
        outcome = nil
    }
}

struct ResultsView: View {
    let playerName: String
    let genre: String
    let winnings: Int
    let questionsAnswered: Int
    let didWinMillion: Bool
    let message: String
    let onPlayAgain: () -> Void
    let onChooseGenre: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: didWinMillion ? "crown.fill" : "flag.checkered.2.crossed")
                .font(.system(size: 64))
                .foregroundStyle(.white, Color.gold)

            Text(didWinMillion ? "You Won the Million" : "Game Over")
                .font(.largeTitle.bold())
                .foregroundStyle(.white)

            Text("\(playerName), you finished the \(genre) round with \(questionsAnswered) correct answer\(questionsAnswered == 1 ? "" : "s").")
                .foregroundStyle(Color.white.opacity(0.82))
                .multilineTextAlignment(.center)

            Text(winnings.currencyString)
                .font(.system(size: 42, weight: .bold, design: .rounded))
                .foregroundStyle(Color.gold)

            Text(message)
                .foregroundStyle(Color.white.opacity(0.82))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 12)

            VStack(spacing: 12) {
                Button("Play Again") {
                    onPlayAgain()
                }
                .buttonStyle(PrimaryActionButtonStyle())

                Button("Choose Another Genre") {
                    onChooseGenre()
                }
                .buttonStyle(SecondaryActionButtonStyle())
            }
        }
        .padding(24)
    }
}

struct InstructionsView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            MillionaireBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text("How to Play")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)

                    instructionCard(
                        title: "Start Strong",
                        body: "Register with your details, then choose one of the five quiz genres."
                    )
                    instructionCard(
                        title: "Beat the Clock",
                        body: "Questions 1 to 5 give you 2 minutes, 6 to 10 give you 1 minute, and the last 5 give you 30 seconds."
                    )
                    instructionCard(
                        title: "Use Hints Wisely",
                        body: "You get three 50:50 hints per game. Each one removes two wrong answers from the current question."
                    )
                    instructionCard(
                        title: "Climb the Ladder",
                        body: "Every correct answer moves you up the prize ladder. A wrong answer or expired timer ends the run."
                    )

                    Button("Back to Menu") {
                        dismiss()
                    }
                    .buttonStyle(PrimaryActionButtonStyle())
                    .padding(.top, 6)
                }
                .padding(24)
            }
        }
        .navigationTitle("Instructions")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func instructionCard(title: String, body: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline.bold())
                .foregroundStyle(.white)

            Text(body)
                .foregroundStyle(Color.white.opacity(0.82))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
