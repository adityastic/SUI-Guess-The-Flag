//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Aditya Gupta on 12/18/19.
//  Copyright © 2019 Aditya Gupta. All rights reserved.
//

import SwiftUI

struct GameState{
    var currentScore = 0
    var wasLastCorrect = false
    var showingScore = false
    var scoreTitle = ""
}

struct ContentView: View {
    @State private var currentGame = GameState()
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var selectedCountry = Int.random(in: 0...2)

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemBackground), .accentColor]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 40) {
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of: ")
                        Text("\(countries[selectedCountry])")
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    ForEach(0..<3) { number in
                        Button(action: {
                            self.flagTapped(number)
                        }) {
                            Image(self.countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 10)
                                .overlay(Capsule().stroke(Color.white, lineWidth: 7))
                        }
                    }
                }

                Text("Correct Guesses: \(currentGame.currentScore)")
                    .font(.headline)
                    .fontWeight(.black)
            }
        }
        .alert(isPresented: $currentGame.showingScore) {
            Alert(title: currentGame.wasLastCorrect ? Text("Nice") : Text("Oops"), message: Text(currentGame.scoreTitle), dismissButton: .default(
                        Text("Continue"), action: {
                            self.askQuestion()
                        }
                    )
                )
        }
    }

    func flagTapped(_ number: Int) {
        if number == selectedCountry {
            currentGame.scoreTitle = "That was the flag for  \(countries[number])"
            currentGame.currentScore += 1
            currentGame.wasLastCorrect = true
        } else {
            currentGame.scoreTitle = "Wrong! That's the flag for \(countries[number])"
            currentGame.wasLastCorrect = false
        }
        currentGame.showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        selectedCountry = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
