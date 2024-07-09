//
//  GenreSelectionView.swift
//  MillionaireGame
//
//  Created by Amartya Karmakar on 2024-07-08.
//

import SwiftUI

struct GenreSelectionView: View {
    let genres = ["Science", "Movies", "Sports", "Current Affairs", "Countries"]
    @State private var selectedGenre: IdentifiableString? = nil

    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Color.black
                Color.gold
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Select a Genre")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()

                ForEach(genres, id: \.self) { genre in
                    Button(action: {
                        selectedGenre = IdentifiableString(value: genre)
                    }) {
                        Text(genre)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                }

                Spacer()
            }
            .padding()
            .fullScreenCover(item: $selectedGenre) { genre in
                GameView(selectedGenre: genre.value)
            }
        }
    }
}

struct GenreSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GenreSelectionView()
    }
}
