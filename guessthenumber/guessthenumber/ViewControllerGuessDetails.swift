//
//  ViewControllerGuessDetails.swift
//  guessthenumber
//
//  Created by istiklal on 3.03.2022.
//


import UIKit

class ViewControllerGuessDetails: UIViewController {

    @IBOutlet weak var guessOrderLabel: UILabel!
    @IBOutlet weak var guessNumberLabel: UILabel!
    @IBOutlet weak var inPlaceLabel: UILabel!
    @IBOutlet weak var notInPlaceLabel: UILabel!
    @IBOutlet weak var guessScoreLabel: UILabel!
    
    var order = ""
    var chosenGuess : Guess? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if chosenGuess != nil {
            guessOrderLabel.text = order
            guessNumberLabel.text = String(chosenGuess!.number)
            inPlaceLabel.text = String(chosenGuess!.inPlace)
            notInPlaceLabel.text = String(chosenGuess!.notInPlace)
            guessScoreLabel.text = String(chosenGuess!.score)
        }
        
    }
    
    

}
