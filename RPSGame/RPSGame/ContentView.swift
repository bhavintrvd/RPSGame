//
//  ContentView.swift
//  RPSGame
//
//  Created by Bhavin Trivedi on 12/13/21.
//

import SwiftUI

struct ContentView: View {
    var rcp = ["Rock", "Paper", "Scissor"]
    
    @State private var shouldWin = Bool.random()
        
    @State private var appSelectedOption = Int.random(in: 0...2)
    
    @State private var showAlert = false
    
    @State private var queNumber = 1
    
    @State private var correctAnswers = 0
    
    @State private var alertTitle = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45, opacity: 0.6), location: 0.3),
                    .init(color: Color(red: 0.66, green: 0.25, blue: 0.56, opacity: 0.3), location: 0.3),
                ], center: .top, startRadius: 40, endRadius: 270)
                    .ignoresSafeArea()
                VStack(alignment: .center, spacing: 15.0) {
                    Text("Your score is \(correctAnswers)")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("App selected \(rcp[appSelectedOption])")
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                    Text("Select option to \(shouldWin ? "WIN" : "LOOSE")")
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                    ForEach(0..<3) { number in
                        Button(action: {
                                checkAnswerAndShowAlert(number: number)
                            }, label: {
                                Text(rcp[number])
                                    .fontWeight(.semibold)
                                    .foregroundColor(.green)
                            })
                    }
                }
            }
            
            .alert(Text(alertTitle), isPresented: $showAlert, actions: {
                Button("OK") {
                    updateQuestion()
                }
            })
            .navigationTitle("Rock Paper Scissor")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func updateQuestion() {
        queNumber += 1
        shouldWin = Bool.random()
        appSelectedOption = Int.random(in: 0...2)
    }
    
    func checkAnswerAndShowAlert(number: Int) {
        let userWin = checkIfCorrectOptionSelected(userSelectedOption: number)
        if userWin { correctAnswers += 1 }
        alertTitle = "You \(userWin ? "won" : "lost")!!"
        if queNumber == 5 {
            resetQuiz()
            alertTitle += "Now resetting the game.."
        }
        showAlert = true
    }
    
    func resetQuiz() {
        correctAnswers = 0
        queNumber = 0
    }
    
    func checkIfCorrectOptionSelected(userSelectedOption: Int) -> Bool {
        switch appSelectedOption {
        case 0:
            return shouldWin ? userSelectedOption == 1 : userSelectedOption == 2
        case 1:
            return shouldWin ? userSelectedOption == 2 : userSelectedOption == 0
        case 2:
            return shouldWin ? userSelectedOption == 0 : userSelectedOption == 1
        default:
            return false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
