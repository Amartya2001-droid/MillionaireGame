//
//  ContentView.swift
//  MillionaireGame
//
//  Created by Amartya Karmakar
//

import SwiftUI

struct ContentView: View {
    @AppStorage("bestWinnings") private var bestWinnings = 0

    var body: some View {
        NavigationStack {
            ZStack {
                MillionaireBackground()

                ScrollView {
                    VStack(spacing: 24) {
                        Spacer(minLength: 32)

                        Image(systemName: "dollarsign.circle.fill")
                            .font(.system(size: 88))
                            .foregroundStyle(.white, Color.gold)

                        VStack(spacing: 10) {
                            Text("Millionaire Game")
                                .font(.largeTitle.bold())
                                .foregroundStyle(.white)

                            Text("Pick a category, beat the clock, and climb the prize ladder all the way to $1,000,000.")
                                .font(.headline)
                                .foregroundStyle(Color.white.opacity(0.82))
                                .multilineTextAlignment(.center)
                        }

                        if bestWinnings > 0 {
                            StatCard(
                                title: "Best Run",
                                value: bestWinnings.currencyString,
                                subtitle: "Saved on this device"
                            )
                        }

                        VStack(spacing: 14) {
                            NavigationLink {
                                RegistrationView()
                            } label: {
                                MenuButtonLabel(title: "Start Game", systemImage: "play.fill")
                            }

                            NavigationLink {
                                InstructionsView()
                            } label: {
                                MenuButtonLabel(title: "Instructions", systemImage: "list.bullet.rectangle.portrait")
                            }
                        }

                        StatCard(
                            title: "Game Rules",
                            value: "15 Questions",
                            subtitle: "You get three 50:50 hints and the timer gets faster as you move up the ladder."
                        )

                        Spacer(minLength: 32)
                    }
                    .padding(.horizontal, 24)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct StatCard: View {
    let title: String
    let value: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.uppercased())
                .font(.caption.weight(.semibold))
                .foregroundStyle(Color.white.opacity(0.7))

            Text(value)
                .font(.title2.bold())
                .foregroundStyle(.white)

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(Color.white.opacity(0.82))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(Color.white.opacity(0.12), lineWidth: 1)
        )
    }
}

#Preview {
    ContentView()
}
