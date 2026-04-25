//
//  QuestionBank.swift
//  MillionaireGame
//

import Foundation

enum QuestionBank {
    static let genres = ["Science", "Movies", "Sports", "Current Affairs", "Countries"]

    static let prizeLadder = [
        1_000, 2_000, 5_000, 10_000, 20_000,
        30_000, 50_000, 75_000, 100_000, 150_000,
        250_000, 350_000, 500_000, 750_000, 1_000_000,
    ]

    static let allQuestions: [GameQuestion] = [
        GameQuestion(text: "What is the chemical symbol for water?", options: ["H2O", "O2", "CO2", "NaCl"], correctAnswer: "H2O", genre: "Science"),
        GameQuestion(text: "What planet is known as the Red Planet?", options: ["Earth", "Mars", "Jupiter", "Saturn"], correctAnswer: "Mars", genre: "Science"),
        GameQuestion(text: "Who developed the theory of relativity?", options: ["Isaac Newton", "Albert Einstein", "Galileo Galilei", "Niels Bohr"], correctAnswer: "Albert Einstein", genre: "Science"),
        GameQuestion(text: "What is the hardest natural substance on Earth?", options: ["Gold", "Iron", "Diamond", "Silver"], correctAnswer: "Diamond", genre: "Science"),
        GameQuestion(text: "Which element has the atomic number 1?", options: ["Helium", "Oxygen", "Hydrogen", "Carbon"], correctAnswer: "Hydrogen", genre: "Science"),
        GameQuestion(text: "What is the powerhouse of the cell?", options: ["Nucleus", "Mitochondria", "Ribosome", "Chloroplast"], correctAnswer: "Mitochondria", genre: "Science"),
        GameQuestion(text: "What gas do plants absorb from the atmosphere?", options: ["Oxygen", "Nitrogen", "Carbon Dioxide", "Hydrogen"], correctAnswer: "Carbon Dioxide", genre: "Science"),
        GameQuestion(text: "What is the approximate speed of light in a vacuum?", options: ["300,000 km/s", "150,000 km/s", "100,000 km/s", "250,000 km/s"], correctAnswer: "300,000 km/s", genre: "Science"),
        GameQuestion(text: "What planet is closest to the sun?", options: ["Earth", "Venus", "Mars", "Mercury"], correctAnswer: "Mercury", genre: "Science"),
        GameQuestion(text: "What is the chemical symbol for gold?", options: ["Au", "Ag", "Pb", "Pt"], correctAnswer: "Au", genre: "Science"),
        GameQuestion(text: "Who is often called the father of modern physics?", options: ["Isaac Newton", "Albert Einstein", "Galileo Galilei", "Nikola Tesla"], correctAnswer: "Albert Einstein", genre: "Science"),
        GameQuestion(text: "What is the most abundant gas in Earth's atmosphere?", options: ["Oxygen", "Nitrogen", "Carbon Dioxide", "Hydrogen"], correctAnswer: "Nitrogen", genre: "Science"),
        GameQuestion(text: "What is the largest planet in our solar system?", options: ["Earth", "Mars", "Jupiter", "Saturn"], correctAnswer: "Jupiter", genre: "Science"),
        GameQuestion(text: "What is the chemical formula for table salt?", options: ["NaCl", "KCl", "MgCl2", "CaCl2"], correctAnswer: "NaCl", genre: "Science"),
        GameQuestion(text: "What type of bond involves the sharing of electron pairs between atoms?", options: ["Ionic bond", "Covalent bond", "Metallic bond", "Hydrogen bond"], correctAnswer: "Covalent bond", genre: "Science"),

        GameQuestion(text: "Who directed the movie \"Inception\"?", options: ["Steven Spielberg", "Christopher Nolan", "James Cameron", "Quentin Tarantino"], correctAnswer: "Christopher Nolan", genre: "Movies"),
        GameQuestion(text: "Which film won Best Picture at the 2020 Academy Awards?", options: ["1917", "Joker", "Parasite", "Ford v Ferrari"], correctAnswer: "Parasite", genre: "Movies"),
        GameQuestion(text: "Which movie features the song \"My Heart Will Go On\"?", options: ["Titanic", "The Bodyguard", "Aladdin", "The Lion King"], correctAnswer: "Titanic", genre: "Movies"),
        GameQuestion(text: "Who played Harry Potter in the film series?", options: ["Daniel Radcliffe", "Rupert Grint", "Elijah Wood", "Tom Felton"], correctAnswer: "Daniel Radcliffe", genre: "Movies"),
        GameQuestion(text: "What year was the first \"Star Wars\" movie released?", options: ["1975", "1977", "1980", "1983"], correctAnswer: "1977", genre: "Movies"),
        GameQuestion(text: "Who directed the movie \"Pulp Fiction\"?", options: ["Steven Spielberg", "Christopher Nolan", "James Cameron", "Quentin Tarantino"], correctAnswer: "Quentin Tarantino", genre: "Movies"),
        GameQuestion(text: "Which actress played Katniss Everdeen in \"The Hunger Games\"?", options: ["Jennifer Lawrence", "Emma Watson", "Scarlett Johansson", "Natalie Portman"], correctAnswer: "Jennifer Lawrence", genre: "Movies"),
        GameQuestion(text: "What is the name of the fictional African country in \"Black Panther\"?", options: ["Zamunda", "Wakanda", "Narnia", "Elbonia"], correctAnswer: "Wakanda", genre: "Movies"),
        GameQuestion(text: "Who directed \"Schindler's List\"?", options: ["Steven Spielberg", "Christopher Nolan", "James Cameron", "Quentin Tarantino"], correctAnswer: "Steven Spielberg", genre: "Movies"),
        GameQuestion(text: "Which movie won the first Academy Award for Best Picture?", options: ["Wings", "Sunrise", "The Jazz Singer", "The Broadway Melody"], correctAnswer: "Wings", genre: "Movies"),
        GameQuestion(text: "In which movie did Humphrey Bogart say, \"Here's looking at you, kid\"?", options: ["Casablanca", "The Maltese Falcon", "To Have and Have Not", "Key Largo"], correctAnswer: "Casablanca", genre: "Movies"),
        GameQuestion(text: "Which movie is based on the life of mathematician John Nash?", options: ["A Beautiful Mind", "Good Will Hunting", "The Theory of Everything", "Hidden Figures"], correctAnswer: "A Beautiful Mind", genre: "Movies"),
        GameQuestion(text: "Who played the Joker in \"The Dark Knight\"?", options: ["Jack Nicholson", "Jared Leto", "Heath Ledger", "Joaquin Phoenix"], correctAnswer: "Heath Ledger", genre: "Movies"),
        GameQuestion(text: "What is the name of the kingdom where the 2013 animated movie \"Frozen\" is set?", options: ["Arendelle", "Corona", "Atlantica", "Narnia"], correctAnswer: "Arendelle", genre: "Movies"),
        GameQuestion(text: "Which film became the first animated movie nominated for Best Picture?", options: ["Beauty and the Beast", "Toy Story", "Shrek", "Up"], correctAnswer: "Beauty and the Beast", genre: "Movies"),

        GameQuestion(text: "What is Canada's official national summer sport?", options: ["Hockey", "Lacrosse", "Basketball", "Soccer"], correctAnswer: "Lacrosse", genre: "Sports"),
        GameQuestion(text: "Which country won the FIFA World Cup in 2018?", options: ["Germany", "Brazil", "France", "Argentina"], correctAnswer: "France", genre: "Sports"),
        GameQuestion(text: "How many players are there in a cricket team?", options: ["9", "10", "11", "12"], correctAnswer: "11", genre: "Sports"),
        GameQuestion(text: "Who holds the record for the most home runs in a single MLB season?", options: ["Barry Bonds", "Babe Ruth", "Hank Aaron", "Alex Rodriguez"], correctAnswer: "Barry Bonds", genre: "Sports"),
        GameQuestion(text: "What is the diameter of a basketball hoop in inches?", options: ["15", "16", "17", "18"], correctAnswer: "18", genre: "Sports"),
        GameQuestion(text: "Which country has won the most Olympic gold medals overall?", options: ["USA", "China", "Russia", "Germany"], correctAnswer: "USA", genre: "Sports"),
        GameQuestion(text: "In which sport would you perform a slam dunk?", options: ["Basketball", "Volleyball", "Tennis", "Football"], correctAnswer: "Basketball", genre: "Sports"),
        GameQuestion(text: "Which boxer is known as \"The Greatest\"?", options: ["Mike Tyson", "Floyd Mayweather", "Muhammad Ali", "Joe Frazier"], correctAnswer: "Muhammad Ali", genre: "Sports"),
        GameQuestion(text: "Which country hosted the 2016 Summer Olympics?", options: ["China", "Brazil", "Greece", "Australia"], correctAnswer: "Brazil", genre: "Sports"),
        GameQuestion(text: "How many points is a touchdown worth in American football before the extra point attempt?", options: ["3", "6", "7", "8"], correctAnswer: "6", genre: "Sports"),
        GameQuestion(text: "At the start of 2026, which men's tennis player held the record for the most Grand Slam singles titles?", options: ["Roger Federer", "Rafael Nadal", "Novak Djokovic", "Pete Sampras"], correctAnswer: "Novak Djokovic", genre: "Sports"),
        GameQuestion(text: "Which country is credited with inventing the modern sport of golf?", options: ["USA", "Scotland", "England", "Ireland"], correctAnswer: "Scotland", genre: "Sports"),
        GameQuestion(text: "Who holds the record for the most goals scored in a single men's FIFA World Cup tournament?", options: ["Pele", "Miroslav Klose", "Just Fontaine", "Ronaldo"], correctAnswer: "Just Fontaine", genre: "Sports"),
        GameQuestion(text: "Which sport is often called the world's game?", options: ["Basketball", "Baseball", "Soccer", "Tennis"], correctAnswer: "Soccer", genre: "Sports"),
        GameQuestion(text: "Which Finnish runner was nicknamed \"The Flying Finn\"?", options: ["Paavo Nurmi", "Usain Bolt", "Carl Lewis", "Jesse Owens"], correctAnswer: "Paavo Nurmi", genre: "Sports"),

        GameQuestion(text: "Who was inaugurated as President of the United States on January 20, 2025?", options: ["Joe Biden", "Donald Trump", "Barack Obama", "George W. Bush"], correctAnswer: "Donald Trump", genre: "Current Affairs"),
        GameQuestion(text: "What year did the United Kingdom formally leave the European Union?", options: ["2016", "2018", "2019", "2020"], correctAnswer: "2020", genre: "Current Affairs"),
        GameQuestion(text: "Which country hosted the Summer Olympics held in 2021?", options: ["Japan", "China", "Brazil", "USA"], correctAnswer: "Japan", genre: "Current Affairs"),
        GameQuestion(text: "Who became Prime Minister of the United Kingdom on July 5, 2024?", options: ["Boris Johnson", "Theresa May", "Rishi Sunak", "Keir Starmer"], correctAnswer: "Keir Starmer", genre: "Current Affairs"),
        GameQuestion(text: "What major event happened on September 11, 2001?", options: ["World Trade Center attacks", "Hurricane Katrina", "2004 Indian Ocean tsunami", "Fukushima nuclear disaster"], correctAnswer: "World Trade Center attacks", genre: "Current Affairs"),
        GameQuestion(text: "Which country launched the Mars mission \"Tianwen-1\"?", options: ["USA", "China", "Russia", "India"], correctAnswer: "China", genre: "Current Affairs"),
        GameQuestion(text: "What is the brand name of the Pfizer-BioNTech COVID-19 vaccine?", options: ["Covaxin", "Sputnik V", "Comirnaty", "Spikevax"], correctAnswer: "Comirnaty", genre: "Current Affairs"),
        GameQuestion(text: "Who is the CEO of Tesla?", options: ["Jeff Bezos", "Elon Musk", "Bill Gates", "Tim Cook"], correctAnswer: "Elon Musk", genre: "Current Affairs"),
        GameQuestion(text: "Which country won the Eurovision Song Contest in 2021?", options: ["Italy", "France", "Switzerland", "Ukraine"], correctAnswer: "Italy", genre: "Current Affairs"),
        GameQuestion(text: "What is the capital of the United Arab Emirates?", options: ["Dubai", "Abu Dhabi", "Sharjah", "Ras Al Khaimah"], correctAnswer: "Abu Dhabi", genre: "Current Affairs"),
        GameQuestion(text: "Who won the Nobel Peace Prize in 2020?", options: ["Greta Thunberg", "Abiy Ahmed", "World Food Programme", "Malala Yousafzai"], correctAnswer: "World Food Programme", genre: "Current Affairs"),
        GameQuestion(text: "Which country has the largest economy in the world by nominal GDP?", options: ["USA", "China", "Japan", "Germany"], correctAnswer: "USA", genre: "Current Affairs"),
        GameQuestion(text: "Who became Federal Chancellor of Germany in May 2025?", options: ["Angela Merkel", "Olaf Scholz", "Friedrich Merz", "Frank-Walter Steinmeier"], correctAnswer: "Friedrich Merz", genre: "Current Affairs"),
        GameQuestion(text: "Which tech company was the first to reach a $2 trillion market capitalization?", options: ["Apple", "Microsoft", "Amazon", "Alphabet"], correctAnswer: "Apple", genre: "Current Affairs"),
        GameQuestion(text: "Who has served as President of Russia since 2012?", options: ["Vladimir Putin", "Dmitry Medvedev", "Mikhail Gorbachev", "Boris Yeltsin"], correctAnswer: "Vladimir Putin", genre: "Current Affairs"),

        GameQuestion(text: "What is the capital city of Japan?", options: ["Kyoto", "Osaka", "Tokyo", "Nagoya"], correctAnswer: "Tokyo", genre: "Countries"),
        GameQuestion(text: "Which country overtook China in 2023 to become the world's most populous country?", options: ["India", "USA", "Indonesia", "Brazil"], correctAnswer: "India", genre: "Countries"),
        GameQuestion(text: "What is the smallest country in the world?", options: ["Monaco", "Malta", "Vatican City", "San Marino"], correctAnswer: "Vatican City", genre: "Countries"),
        GameQuestion(text: "Which country is known as the Land of the Rising Sun?", options: ["China", "Japan", "South Korea", "Thailand"], correctAnswer: "Japan", genre: "Countries"),
        GameQuestion(text: "Which country is the largest by area?", options: ["Canada", "USA", "Russia", "China"], correctAnswer: "Russia", genre: "Countries"),
        GameQuestion(text: "Which country is home to the kangaroo?", options: ["USA", "India", "Australia", "South Africa"], correctAnswer: "Australia", genre: "Countries"),
        GameQuestion(text: "What is the national language of Brazil?", options: ["Spanish", "Portuguese", "French", "English"], correctAnswer: "Portuguese", genre: "Countries"),
        GameQuestion(text: "Which country has the longest coastline?", options: ["USA", "Canada", "Australia", "Russia"], correctAnswer: "Canada", genre: "Countries"),
        GameQuestion(text: "Which country is known for the Eiffel Tower?", options: ["Italy", "Germany", "France", "Spain"], correctAnswer: "France", genre: "Countries"),
        GameQuestion(text: "Which country is famous for maple syrup?", options: ["USA", "Canada", "Norway", "Finland"], correctAnswer: "Canada", genre: "Countries"),
        GameQuestion(text: "Which country is the largest producer of coffee?", options: ["Vietnam", "Colombia", "Brazil", "Ethiopia"], correctAnswer: "Brazil", genre: "Countries"),
        GameQuestion(text: "What is the official language of Egypt?", options: ["English", "Arabic", "French", "Spanish"], correctAnswer: "Arabic", genre: "Countries"),
        GameQuestion(text: "Which country is known for the Great Wall?", options: ["India", "China", "Japan", "South Korea"], correctAnswer: "China", genre: "Countries"),
        GameQuestion(text: "What is the capital city of Canada?", options: ["Toronto", "Vancouver", "Ottawa", "Montreal"], correctAnswer: "Ottawa", genre: "Countries"),
        GameQuestion(text: "Which country is called the Land of a Thousand Lakes?", options: ["Norway", "Sweden", "Finland", "Denmark"], correctAnswer: "Finland", genre: "Countries"),
    ]

    static func questions(for genre: String) -> [GameQuestion] {
        allQuestions.filter { $0.genre == genre }
    }
}
