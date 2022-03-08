//
//  Guess.swift
//  guessthenumber
//
//  Created by istiklal on 3.03.2022.
//

import Foundation

class Guess {
    
    var number : Int
    var numberToGuess : [Int]
    var inPlace : Int
    var notInPlace : Int
    var score : Int
    var guessCount : Int
    var guessType : GuessType
    
    init(digitList : [Int], numberToGuess : [Int], guessCount : Int) {
        self.number = Int(digitList.map(String.init).joined())!  // we don't suppose to see nil value for digitList !!
        self.numberToGuess = numberToGuess
        self.inPlace = 0
        self.notInPlace = 0
        self.score = 0
        self.guessCount = guessCount
        self.guessType = GuessType.NoClue
        // we call guess result method and assign returning values to inPlace and notInPlace and also calculate the score for this guess
        let result = guessResults(generated_number: numberToGuess, guess: digitList)
        self.inPlace = result[0]
        self.notInPlace = result[1]
        // It's negative score, it means every single guess attempt return a negative score and decrease your total score...
        self.score = (self.inPlace*0 + self.notInPlace*10 + (4 - self.inPlace - self.notInPlace)*20)
    }
    
    func guessResults(generated_number:[Int], guess:[Int]) -> [Int] {
        /** */
        let generatedNumberSet = Set(generated_number)
        let guessSet = Set(guess)
        let commons = generatedNumberSet.intersection(guessSet)
        print("istiklal [Guess.guessResults]","Common digits : \(commons)")
        var countInPlace : Int=0
        var countNotInPlace : Int=0

        if commons.count > 0 {
            commons.forEach { it in
                if(generated_number.firstIndex(of:it) == guess.firstIndex(of: it)){
                    countInPlace+=1
                }else{
                    countNotInPlace+=1
                }
            }
            switch (commons.count) {
            case 4:
                self.guessType = GuessType.WinnerGuess
            case 3:
                self.guessType = GuessType.OrdinaryGuess
            default:
                self.guessType = GuessType.OrdinaryGuess
            }
        } else {
            self.guessType = GuessType.GreatGuess
        }
        
        return [countInPlace, countNotInPlace]
    }
    
    func isWinner() -> Bool {
        return self.inPlace == 4 && self.notInPlace == 0
    }
    
}

//
enum GuessType {
    case WinnerGuess
    case FailedGuess
    case OrdinaryGuess
    case GreatGuess
    case NoClue
}
