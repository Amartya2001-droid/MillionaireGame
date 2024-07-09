//
//  ContentView.swift
//  MillionaireGame
//
//  Created by Amartya Karmakar on 2024-07-08.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var navigationState = NavigationState()

    var body: some View {
        NavigationView {
            ZStack {
                HStack(spacing: 0) {
                    Color.black
                    Color.gold
                }
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("Designer-3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .padding(.top, 50)
                    
                    NavigationLink(destination: RegistrationView()
                        .environmentObject(navigationState)) {
                        Text("Start Game")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    NavigationLink(destination: InstructionsView()) {
                        Text("Instructions")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    Button(action: {
                        // Action for settings if needed
                    }) {
                        Text("Settings")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    Spacer()
                }
            }
        }
        .environmentObject(navigationState)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
