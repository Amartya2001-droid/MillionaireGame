//
//  InstructionsView.swift
//  MillionaireGame
//
//  Created by Amartya Karmakar on 2024-07-09.
//

import SwiftUI

struct InstructionsView: View {
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Color.black
                Color.gold
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text("Game Instructions")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                
                Text("""
                Welcome to the Millionaire Game!
                
                1. Enter your details to start.
                2. Select a genre for the questions.
                3. Answer 15 questions within the time limit.
                4. The first 5 questions have a time limit of 2 minutes each.
                5. The next 5 questions have a time limit of 1 minute each.
                6. The last 5 questions have a time limit of 30 seconds each.
                7. You have 3 hints available to eliminate two incorrect options.
                8. Your score is based on the number of correct answers.
                9. Have fun and good luck!
                """)
                .font(.body)
                .foregroundColor(.white)
                .padding()

                Spacer()
                
                Button(action: {
                    // Action to go back to the main menu or start the game
                }) {
                    Text("Back")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
