//
//  RegistrationView.swift
//  MillionaireGame
//
//  Created by Amartya Karmakar on 2024-07-08.
//

import SwiftUI

struct RegistrationView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var dob = Date()
    @State private var showGenreSelection = false

    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Color.black
                Color.gold
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text("Enter your details")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                
                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                DatePicker("Date of Birth", selection: $dob, displayedComponents: .date)
                    .padding()
                    .colorInvert() // Invert color to ensure visibility on black background
                
                Button(action: {
                    showGenreSelection.toggle()
                }) {
                    Text("Next")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                .fullScreenCover(isPresented: $showGenreSelection) {
                    GenreSelectionView()
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
