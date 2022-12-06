//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Micah Steele on 12/2/22.
//

import SwiftUI

struct ContentView: View {
    @State private var currentScore = 0
    @State private var quesitonCounter = 1
    @State private var showingScore = false
    @State private var showingResults = false
    @State private var scoreTitle = ""
    @State private var shouldWin = Bool.random()
    @State private var computerChoice = Int.random(in: 0...2)
    
    let choiceImages = ["🪨", "🧻", "✂️"]
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.indigo, .black]), center: .center, startRadius: 200, endRadius: 1000)
            .ignoresSafeArea()
            VStack {
                Spacer()
                VStack {
                    Text("Computer played")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text("\(choiceImages[computerChoice])")
                        .font(.system(size: 200))
                    Text("which one \(shouldWin ? "Wins" : "Loses")")
                        .font(.title)
                        .foregroundColor(shouldWin ? .primary : .red)
                    HStack {
                        ForEach(0..<3) { number in
                            Button {
                                correctButtonTapped(number)
                            } label: {
                                Text("\(choiceImages[number])")
                                    .font(.system(size: 100))
                            }
                        }
                    }
                }
                Spacer()
                Text("Score: \(currentScore)")
                    .font(.title.weight(.bold))
                    .foregroundColor(.primary)
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if scoreTitle == "Correct!" {
                Text("Your Score is \(currentScore)")
            } else {
                Text("You lost that round")
            }
        }
        .alert("Game Over", isPresented: $showingResults) {
            Button("Play Again", action: newGame)
        } message: {
            Text("Your final score was \(currentScore)")
        }
    }
    
    func correctButtonTapped(_ choice: Int) {
        let didWin: Bool
        let winningMoves = [1, 2, 0]
        
        if shouldWin {
            didWin = choice == winningMoves[computerChoice]
        } else {
            didWin = winningMoves[choice] == computerChoice
        }
        
        if didWin {
            scoreTitle = "Correct!"
            currentScore += 1
        } else {
            scoreTitle = "Wrong!"
            
            if currentScore > 0 {
                currentScore -= 1
            }
        }
        
        if quesitonCounter == 10 {
            showingResults = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        computerChoice = Int.random(in: 0...2)
        quesitonCounter += 1
        shouldWin = Bool.random()
    }
    
    func newGame() {
        quesitonCounter = 1
        currentScore = 0
        askQuestion()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
