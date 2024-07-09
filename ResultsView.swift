//
//  ResultsView.swift
//  MillionaireGame
//
//  Created by Amartya Karmakar on 2024-07-08.
//

import SwiftUI

struct ResultsView: View {
    var score: Int
    @EnvironmentObject var navigationState: NavigationState

    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Color.black
                Color.gold
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Game Over")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()

                Text("You won $\(score)")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()

                Button(action: {
                    navigationState.shouldShowGenreSelection = true
                }) {
                    Text("Play Again")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(score: 0)
            .environmentObject(NavigationState())
    }
}
