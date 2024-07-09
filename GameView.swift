//
//  GameView.swift
//  MillionaireGame
//
//  Created by Amartya Karmakar on 2024-07-08.
//

import SwiftUI

struct Question {
    let text: String
    var options: [String]
    let correctAnswer: String
    let genre: String
}

struct GameView: View {
    @State private var allQuestions: [Question] = [
        // Science Questions
        Question(text: "What is the chemical symbol for water?", options: ["H2O", "O2", "CO2", "NaCl"], correctAnswer: "H2O", genre: "Science"),
        Question(text: "What planet is known as the Red Planet?", options: ["Earth", "Mars", "Jupiter", "Saturn"], correctAnswer: "Mars", genre: "Science"),
        Question(text: "Who developed the theory of relativity?", options: ["Isaac Newton", "Albert Einstein", "Galileo Galilei", "Niels Bohr"], correctAnswer: "Albert Einstein", genre: "Science"),
        Question(text: "What is the hardest natural substance on Earth?", options: ["Gold", "Iron", "Diamond", "Silver"], correctAnswer: "Diamond", genre: "Science"),
        Question(text: "Which element has the atomic number 1?", options: ["Helium", "Oxygen", "Hydrogen", "Carbon"], correctAnswer: "Hydrogen", genre: "Science"),
        Question(text: "What is the powerhouse of the cell?", options: ["Nucleus", "Mitochondria", "Ribosome", "Chloroplast"], correctAnswer: "Mitochondria", genre: "Science"),
        Question(text: "What gas do plants absorb from the atmosphere?", options: ["Oxygen", "Nitrogen", "Carbon Dioxide", "Hydrogen"], correctAnswer: "Carbon Dioxide", genre: "Science"),
        Question(text: "What is the speed of light?", options: ["300,000 km/s", "150,000 km/s", "100,000 km/s", "250,000 km/s"], correctAnswer: "300,000 km/s", genre: "Science"),
        Question(text: "What planet is closest to the sun?", options: ["Earth", "Venus", "Mars", "Mercury"], correctAnswer: "Mercury", genre: "Science"),
        Question(text: "What is the chemical symbol for gold?", options: ["Au", "Ag", "Pb", "Pt"], correctAnswer: "Au", genre: "Science"),
        Question(text: "Who is known as the father of modern physics?", options: ["Isaac Newton", "Albert Einstein", "Galileo Galilei", "Nikola Tesla"], correctAnswer: "Albert Einstein", genre: "Science"),
        Question(text: "What is the most abundant gas in Earth's atmosphere?", options: ["Oxygen", "Nitrogen", "Carbon Dioxide", "Hydrogen"], correctAnswer: "Nitrogen", genre: "Science"),
        Question(text: "What is the largest planet in our solar system?", options: ["Earth", "Mars", "Jupiter", "Saturn"], correctAnswer: "Jupiter", genre: "Science"),
        Question(text: "What is the chemical formula for table salt?", options: ["NaCl", "KCl", "MgCl2", "CaCl2"], correctAnswer: "NaCl", genre: "Science"),
        Question(text: "What type of bond involves the sharing of electron pairs between atoms?", options: ["Ionic bond", "Covalent bond", "Metallic bond", "Hydrogen bond"], correctAnswer: "Covalent bond", genre: "Science"),

        // Movies Questions
        Question(text: "Who directed the movie 'Inception'?", options: ["Steven Spielberg", "Christopher Nolan", "James Cameron", "Quentin Tarantino"], correctAnswer: "Christopher Nolan", genre: "Movies"),
        Question(text: "Who won the Best Actor Oscar in 2020?", options: ["Joaquin Phoenix", "Leonardo DiCaprio", "Brad Pitt", "Tom Hanks"], correctAnswer: "Joaquin Phoenix", genre: "Movies"),
        Question(text: "What is the highest-grossing film of all time?", options: ["Titanic", "Avatar", "Avengers: Endgame", "Star Wars: The Force Awakens"], correctAnswer: "Avengers: Endgame", genre: "Movies"),
        Question(text: "Which movie features the song 'My Heart Will Go On'?", options: ["Titanic", "The Bodyguard", "Aladdin", "The Lion King"], correctAnswer: "Titanic", genre: "Movies"),
        Question(text: "Who played the character of Harry Potter in the film series?", options: ["Daniel Radcliffe", "Rupert Grint", "Elijah Wood", "Tom Felton"], correctAnswer: "Daniel Radcliffe", genre: "Movies"),
        Question(text: "What year was the first 'Star Wars' movie released?", options: ["1975", "1977", "1980", "1983"], correctAnswer: "1977", genre: "Movies"),
        Question(text: "Who directed the movie 'Pulp Fiction'?", options: ["Steven Spielberg", "Christopher Nolan", "James Cameron", "Quentin Tarantino"], correctAnswer: "Quentin Tarantino", genre: "Movies"),
        Question(text: "Which actress played Katniss Everdeen in 'The Hunger Games'?", options: ["Jennifer Lawrence", "Emma Watson", "Scarlett Johansson", "Natalie Portman"], correctAnswer: "Jennifer Lawrence", genre: "Movies"),
        Question(text: "What is the name of the fictional African country in 'Black Panther'?", options: ["Zamunda", "Wakanda", "Narnia", "Elbonia"], correctAnswer: "Wakanda", genre: "Movies"),
        Question(text: "Who directed the movie 'Schindler's List'?", options: ["Steven Spielberg", "Christopher Nolan", "James Cameron", "Quentin Tarantino"], correctAnswer: "Steven Spielberg", genre: "Movies"),
        Question(text: "Which movie won the first-ever Academy Award for Best Picture?", options: ["Wings", "Sunrise", "The Jazz Singer", "The Broadway Melody"], correctAnswer: "Wings", genre: "Movies"),
        Question(text: "In which movie did Humphrey Bogart say, 'Here's looking at you, kid'?", options: ["Casablanca", "The Maltese Falcon", "To Have and Have Not", "Key Largo"], correctAnswer: "Casablanca", genre: "Movies"),
        Question(text: "Which movie is based on the life of mathematician John Nash?", options: ["A Beautiful Mind", "Good Will Hunting", "The Theory of Everything", "Hidden Figures"], correctAnswer: "A Beautiful Mind", genre: "Movies"),
        Question(text: "Who played the Joker in 'The Dark Knight'?", options: ["Jack Nicholson", "Jared Leto", "Heath Ledger", "Joaquin Phoenix"], correctAnswer: "Heath Ledger", genre: "Movies"),
        Question(text: "What is the name of the kingdom where the 2013 animated movie 'Frozen' is set?", options: ["Arendelle", "Corona", "Atlantica", "Narnia"], correctAnswer: "Arendelle", genre: "Movies"),

        // Sports Questions
        Question(text: "What is the national sport of Canada?", options: ["Hockey", "Lacrosse", "Basketball", "Soccer"], correctAnswer: "Lacrosse", genre: "Sports"),
        Question(text: "Which country won the FIFA World Cup in 2018?", options: ["Germany", "Brazil", "France", "Argentina"], correctAnswer: "France", genre: "Sports"),
        Question(text: "How many players are there in a cricket team?", options: ["9", "10", "11", "12"], correctAnswer: "11", genre: "Sports"),
        Question(text: "Who holds the record for the most home runs in a single MLB season?", options: ["Barry Bonds", "Babe Ruth", "Hank Aaron", "Alex Rodriguez"], correctAnswer: "Barry Bonds", genre: "Sports"),
        Question(text: "What is the diameter of a basketball hoop in inches?", options: ["15", "16", "17", "18"], correctAnswer: "18", genre: "Sports"),
        Question(text: "Which country has won the most Olympic gold medals?", options: ["USA", "China", "Russia", "Germany"], correctAnswer: "USA", genre: "Sports"),
        Question(text: "In which sport would you perform a slam dunk?", options: ["Basketball", "Volleyball", "Tennis", "Football"], correctAnswer: "Basketball", genre: "Sports"),
        Question(text: "Which boxer is known as 'The Greatest' and 'The People's Champion'?", options: ["Mike Tyson", "Floyd Mayweather", "Muhammad Ali", "Joe Frazier"], correctAnswer: "Muhammad Ali", genre: "Sports"),
        Question(text: "Which country hosted the 2016 Summer Olympics?", options: ["China", "Brazil", "Greece", "Australia"], correctAnswer: "Brazil", genre: "Sports"),
        Question(text: "How many points is a touchdown worth in American football?", options: ["3", "6", "7", "8"], correctAnswer: "6", genre: "Sports"),
        Question(text: "Which tennis player has won the most Grand Slam titles?", options: ["Roger Federer", "Rafael Nadal", "Novak Djokovic", "Pete Sampras"], correctAnswer: "Roger Federer", genre: "Sports"),
        Question(text: "Which country is known for inventing the sport of golf?", options: ["USA", "Scotland", "England", "Ireland"], correctAnswer: "Scotland", genre: "Sports"),
        Question(text: "Who holds the record for the most goals scored in a single World Cup?", options: ["Pele", "Miroslav Klose", "Just Fontaine", "Ronaldo"], correctAnswer: "Just Fontaine", genre: "Sports"),
        Question(text: "What sport is known as the 'king of sports'?", options: ["Basketball", "Baseball", "Soccer", "Tennis"], correctAnswer: "Soccer", genre: "Sports"),
        Question(text: "Which famous athlete is known as 'The Flying Finn'?", options: ["Paavo Nurmi", "Usain Bolt", "Carl Lewis", "Jesse Owens"], correctAnswer: "Paavo Nurmi", genre: "Sports"),

        // Current Affairs Questions
        Question(text: "Who is the current president of the United States?", options: ["Joe Biden", "Donald Trump", "Barack Obama", "George W. Bush"], correctAnswer: "Joe Biden", genre: "Current Affairs"),
        Question(text: "What year did the UK leave the European Union?", options: ["2016", "2018", "2019", "2020"], correctAnswer: "2020", genre: "Current Affairs"),
        Question(text: "Which country hosted the 2021 Summer Olympics?", options: ["Japan", "China", "Brazil", "USA"], correctAnswer: "Japan", genre: "Current Affairs"),
        Question(text: "What is the name of the current UK Prime Minister?", options: ["Boris Johnson", "Theresa May", "David Cameron", "Rishi Sunak"], correctAnswer: "Rishi Sunak", genre: "Current Affairs"),
        Question(text: "What major event happened on September 11, 2001?", options: ["World Trade Center attacks", "Hurricane Katrina", "Tsunami in Indonesia", "Fukushima nuclear disaster"], correctAnswer: "World Trade Center attacks", genre: "Current Affairs"),
        Question(text: "Which country recently launched the Mars mission 'Tianwen-1'?", options: ["USA", "China", "Russia", "India"], correctAnswer: "China", genre: "Current Affairs"),
        Question(text: "What is the name of the COVID-19 vaccine developed by Pfizer?", options: ["Covaxin", "Sputnik V", "Comirnaty", "Moderna"], correctAnswer: "Comirnaty", genre: "Current Affairs"),
        Question(text: "Who is the current CEO of Tesla?", options: ["Jeff Bezos", "Elon Musk", "Bill Gates", "Tim Cook"], correctAnswer: "Elon Musk", genre: "Current Affairs"),
        Question(text: "Which country won the Eurovision Song Contest in 2021?", options: ["Italy", "France", "Switzerland", "Ukraine"], correctAnswer: "Italy", genre: "Current Affairs"),
        Question(text: "What is the capital of the United Arab Emirates?", options: ["Dubai", "Abu Dhabi", "Sharjah", "Ras Al Khaimah"], correctAnswer: "Abu Dhabi", genre: "Current Affairs"),
        Question(text: "Who won the Nobel Peace Prize in 2020?", options: ["Greta Thunberg", "Abiy Ahmed", "World Food Programme", "Malala Yousafzai"], correctAnswer: "World Food Programme", genre: "Current Affairs"),
        Question(text: "Which country has the largest economy in the world?", options: ["USA", "China", "Japan", "Germany"], correctAnswer: "USA", genre: "Current Affairs"),
        Question(text: "What is the name of the current Chancellor of Germany?", options: ["Angela Merkel", "Olaf Scholz", "Gerhard Schröder", "Helmut Kohl"], correctAnswer: "Olaf Scholz", genre: "Current Affairs"),
        Question(text: "Which tech company became the first to reach a $2 trillion market cap?", options: ["Apple", "Microsoft", "Amazon", "Google"], correctAnswer: "Apple", genre: "Current Affairs"),
        Question(text: "What is the name of the current President of Russia?", options: ["Vladimir Putin", "Dmitry Medvedev", "Mikhail Gorbachev", "Boris Yeltsin"], correctAnswer: "Vladimir Putin", genre: "Current Affairs"),

        // Countries Questions
        Question(text: "What is the capital city of Japan?", options: ["Kyoto", "Osaka", "Tokyo", "Nagoya"], correctAnswer: "Tokyo", genre: "Countries"),
        Question(text: "Which country has the largest population?", options: ["India", "USA", "Indonesia", "China"], correctAnswer: "China", genre: "Countries"),
        Question(text: "What is the smallest country in the world?", options: ["Monaco", "Malta", "Vatican City", "San Marino"], correctAnswer: "Vatican City", genre: "Countries"),
        Question(text: "Which country is known as the Land of the Rising Sun?", options: ["China", "Japan", "South Korea", "Thailand"], correctAnswer: "Japan", genre: "Countries"),
        Question(text: "Which country is the largest by area?", options: ["Canada", "USA", "Russia", "China"], correctAnswer: "Russia", genre: "Countries"),
        Question(text: "Which country is home to the kangaroo?", options: ["USA", "India", "Australia", "South Africa"], correctAnswer: "Australia", genre: "Countries"),
        Question(text: "What is the national language of Brazil?", options: ["Spanish", "Portuguese", "French", "English"], correctAnswer: "Portuguese", genre: "Countries"),
        Question(text: "Which country has the longest coastline?", options: ["USA", "Canada", "Australia", "Russia"], correctAnswer: "Canada", genre: "Countries"),
        Question(text: "Which country is known for the Eiffel Tower?", options: ["Italy", "Germany", "France", "Spain"], correctAnswer: "France", genre: "Countries"),
        Question(text: "Which country is famous for its maple syrup?", options: ["USA", "Canada", "Norway", "Finland"], correctAnswer: "Canada", genre: "Countries"),
        Question(text: "Which country is the largest producer of coffee?", options: ["Vietnam", "Colombia", "Brazil", "Ethiopia"], correctAnswer: "Brazil", genre: "Countries"),
        Question(text: "What is the official language of Egypt?", options: ["English", "Arabic", "French", "Spanish"], correctAnswer: "Arabic", genre: "Countries"),
        Question(text: "Which country is known for the Great Wall?", options: ["India", "China", "Japan", "South Korea"], correctAnswer: "China", genre: "Countries"),
        Question(text: "What is the capital city of Canada?", options: ["Toronto", "Vancouver", "Ottawa", "Montreal"], correctAnswer: "Ottawa", genre: "Countries"),
        Question(text: "Which country is known as the Land of a Thousand Lakes?", options: ["Norway", "Sweden", "Finland", "Denmark"], correctAnswer: "Finland", genre: "Countries")
    ]

        @State private var questions: [Question] = []
        @State private var currentQuestionIndex = 0
        @State private var selectedAnswer: String? = nil
        @State private var timeRemaining = 120
        @State private var timerColor = Color.green
        @State private var showHint = false
        @State private var hintsUsed = 0
        @State private var score = 0
        @State private var showResults = false
        var selectedGenre: String
        @EnvironmentObject var navigationState: NavigationState

        var body: some View {
            ZStack {
                HStack(spacing: 0) {
                    Color.black
                    Color.gold
                }
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if showResults {
                        ResultsView(score: score)
                            .environmentObject(navigationState)
                    } else {
                        if questions.isEmpty {
                            Text("No questions available for this genre.")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                        } else {
                            Text(questions[currentQuestionIndex].text)
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                            
                            ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                                Button(action: {
                                    selectedAnswer = option
                                    // Handle option selection
                                    if option == questions[currentQuestionIndex].correctAnswer {
                                        // Correct answer
                                        score += 20000
                                        if currentQuestionIndex < questions.count - 1 {
                                            currentQuestionIndex += 1
                                            resetTimer()
                                        } else {
                                            // Game over, user won
                                            showResults = true
                                        }
                                    } else {
                                        // Incorrect answer, game over
                                        showResults = true
                                    }
                                }) {
                                    Text(option)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                }
                                .padding()
                            }
                            
                            Text("Time Remaining: \(timeFormatted(timeRemaining))")
                                .foregroundColor(timerColor)
                                .font(.headline)
                                .padding()
                            
                            Button(action: {
                                useHint()
                            }) {
                                Text("Hint (\(hintsUsed)/3)")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            .padding()
                            .disabled(hintsUsed >= 3)
                            
                            Spacer()
                        }
                    }
                }
                .onAppear {
                    filterQuestionsByGenre()
                    startTimer()
                }
                .padding()
            }
            .onChange(of: navigationState.shouldShowGenreSelection) { newValue in
                if newValue {
                    navigationState.shouldShowGenreSelection = false
                    // Navigate to GenreSelectionView
                }
            }
        }
        
        func startTimer() {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                    if self.timeRemaining <= 10 {
                        self.timerColor = Color.red
                    } else if self.timeRemaining <= 30 {
                        self.timerColor = Color.orange
                    }
                } else {
                    timer.invalidate()
                    // Handle timer end
                    // Game over, time ran out
                    self.showResults = true
                }
            }
        }
        
        func resetTimer() {
            self.timeRemaining = currentQuestionIndex < 5 ? 120 : currentQuestionIndex < 10 ? 60 : 30
            self.timerColor = Color.green
        }
        
        func useHint() {
            self.hintsUsed += 1
            // Eliminate two incorrect options
            let correctAnswer = questions[currentQuestionIndex].correctAnswer
            let incorrectOptions = questions[currentQuestionIndex].options.filter { $0 != correctAnswer }
            let optionsToRemove = Array(incorrectOptions.prefix(2))
            questions[currentQuestionIndex].options.removeAll { optionsToRemove.contains($0) }
        }
        
        func resetGame() {
            self.currentQuestionIndex = 0
            self.selectedAnswer = nil
            self.timeRemaining = 120
            self.timerColor = Color.green
            self.showHint = false
            self.hintsUsed = 0
            self.score = 0
            self.showResults = false
            filterQuestionsByGenre()
            startTimer()
        }
        
        func filterQuestionsByGenre() {
            self.questions = allQuestions.filter { $0.genre == selectedGenre }
            if self.questions.count > 15 {
                self.questions = Array(self.questions.shuffled().prefix(15))
            }
        }
        
        func timeFormatted(_ totalSeconds: Int) -> String {
            let minutes = totalSeconds / 60
            let seconds = totalSeconds % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }

    struct GameView_Previews: PreviewProvider {
        static var previews: some View {
            GameView(selectedGenre: "Science")
                .environmentObject(NavigationState())
        }
    }
