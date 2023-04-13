//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mykola Zakluka on 11.04.2023.
//

import SwiftUI

struct ContentView: View {
    let maxQuestionCount = 8
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var wrongTitle = ""
    @State private var totalScore = 0
    @State private var wrong = false
    @State private var countQuestions = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Ukraine", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("Questions: \(countQuestions)/\(maxQuestionCount)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                Spacer()
                Spacer()
                
                Text("Score: \(totalScore)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
        }
        .alert(wrongTitle, isPresented: $wrong) {
            Button("Continue") {}
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Reset", action: reset)
        } message: {
            Text("You score is \(totalScore)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            totalScore += 1
        } else {
            wrongTitle = "Wrong! That’s the flag of \(countries[number])"
            wrong = true
        }
        countQuestions += 1
        newQuestion()
        
        if countQuestions == maxQuestionCount {
            showingScore = true
        }
    }
    
    func reset() {
        newQuestion()
        
        totalScore = 0
        countQuestions = 0
    }
    
    
    func newQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
