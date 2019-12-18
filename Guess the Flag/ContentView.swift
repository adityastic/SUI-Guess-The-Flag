//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Aditya Gupta on 12/18/19.
//  Copyright © 2019 Aditya Gupta. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var selectedCountry = Int.random(in: 0...2)

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of: ")
                        .foregroundColor(Color.white)
                    Text("\(countries[selectedCountry])")
                        .foregroundColor(Color.white)
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
        }
            .alert(isPresented: $showingScore) {
                Alert(title: Text("Your Choice was:"), message: Text(scoreTitle), dismissButton: .default(
                        Text("Continue"), action: {
                            self.askQuestion()
                        }
                    )
                )
        }
    }

    func flagTapped(_ number: Int) {
        if number == selectedCountry {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
        self.showingScore = true
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
