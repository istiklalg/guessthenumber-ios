//
//  ViewControllerGameSelection.swift
//  guessthenumber
//
//  Created by istiklal on 23.02.2022.
//


import UIKit

class ViewControllerGameSelection: UIViewController {

    @IBOutlet weak var playerNameLabel: UILabel!
    var currentPlayer : String?
    let notReadyMessage = UIAlertController(title: "Coming Soon",
                                       message: "This part will be available next update.",
                                       preferredStyle: UIAlertController.Style.alert)
//    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
//        // code for acception
//    }
    let cancelButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel) { UIAlertAction in
        // code for cancelation ...
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // notReadyMessage.addAction(okButton)
        notReadyMessage.addAction(cancelButton)
        // Do any additional setup after loading the view.
        playerNameLabel.text = "Have a great time " + currentPlayer!
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectionToSinglePlayer" {
            
        }
    }
    

    @IBAction func playSinglePlayer(_ sender: Any) {
        
        performSegue(withIdentifier: "selectionToSinglePlayer", sender: nil)
        
    }
    
    @IBAction func playWithMachine(_ sender: Any) {
        // This part of game is nott ready yet ...
        self.present(notReadyMessage, animated: true, completion: nil)
    }
    
    @IBAction func playMultiPlayer(_ sender: Any) {
        // This part of game is not ready yet ...
        self.present(notReadyMessage, animated: true, completion: nil)
    }
    
    
    
}
