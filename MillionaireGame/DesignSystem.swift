//
//  DesignSystem.swift
//  MillionaireGame
//

import SwiftUI

struct MillionaireBackground: View {
    var body: some View {
        LinearGradient(
            colors: [Color.black, Color(red: 0.17, green: 0.12, blue: 0.02), Color.gold.opacity(0.92)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        .overlay(
            RadialGradient(
                colors: [Color.white.opacity(0.14), Color.clear],
                center: .topTrailing,
                startRadius: 30,
                endRadius: 380
            )
            .ignoresSafeArea()
        )
    }
}

struct MenuButtonLabel: View {
    let title: String
    let systemImage: String

    var body: some View {
        HStack {
            Image(systemName: systemImage)
            Text(title)
                .fontWeight(.semibold)
            Spacer()
            Image(systemName: "arrow.right")
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
    }
}

struct PrimaryActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.gold.opacity(configuration.isPressed ? 0.82 : 1))
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.99 : 1)
    }
}

struct SecondaryActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.white.opacity(configuration.isPressed ? 0.08 : 0.12))
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.white.opacity(0.14), lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.99 : 1)
    }
}

struct GenreButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .background(Color.white.opacity(configuration.isPressed ? 0.08 : 0.12))
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.white.opacity(0.12), lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.99 : 1)
    }
}

struct AnswerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .background(Color.blue.opacity(configuration.isPressed ? 0.68 : 0.82))
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.99 : 1)
    }
}

extension Color {
    static let gold = Color(red: 1, green: 0.84, blue: 0)
}

extension Int {
    var currencyString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self)) ?? "$\(self)"
    }
}
