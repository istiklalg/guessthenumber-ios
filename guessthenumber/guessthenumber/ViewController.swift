//
//  ViewController.swift
//  guessthenumber
//
//  Created by istiklal on 22.02.2022.
//


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playerName : UILabel!
    @IBOutlet weak var playerNameInput : UITextField!
    var currentPlayer : String?

    override func viewDidLoad() {
        // like onCreate() in android
        super.viewDidLoad()
        
        // closing the keyboard with tapping outside
//        let gestureRecognizer = UIGestureRecognizer(target: self, action: #selector(closeKeyboard))
//        view.addGestureRecognizer(gestureRecognizer)
        
        // we use if let to handle nil value ..
        if let currentPlayer = UserDefaults.standard.object(forKey : "player") as? String {
            playerNameInput.isHidden = true
            playerName.text = currentPlayer
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // like onStart() in android
    }
    
    
    // This function let us to seperate segues from each other and make some preperation operations in here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainToGameSelection" {
            let destinationVC = segue.destination as! ViewControllerGameSelection
            // now we can use the target view controller as a variable ..
            destinationVC.currentPlayer = currentPlayer
        }
    }
    
    
    @IBAction func gameSelectionScreen(_ sender: Any) {
        
        let inputText = playerNameInput.text
        if self.currentPlayer != nil {
            // There is a player name saved before and go on with it..
            print("currentPlayer is : \(self.currentPlayer ?? "nil")")
            UserDefaults.standard.set(self.currentPlayer, forKey: "player")
            performSegue(withIdentifier: "mainToGameSelection", sender: nil)
        } else {
            if inputText != Optional("") {
                // There is no saved player name, user gave us a name
                print("inputText is : \(inputText ?? "")")
                currentPlayer = "\(inputText!)"
                UserDefaults.standard.set(self.currentPlayer, forKey: "player")
                // we manage segue (intent) which prepare to game selection screen for us
                playerNameInput.isHidden = true
                playerNameInput.resignFirstResponder()
                playerName.text = self.currentPlayer
                performSegue(withIdentifier: "mainToGameSelection", sender: nil)
            } else {
                // There is no saved player name and user trying to pass input field blank, show a notification
                print("currentPlayer is : \(self.currentPlayer ?? "nil") & inputText is : \(inputText ?? "")")
                playerNameInput.isHidden = false
                playerName.text = ""
            }
        }
    }
    
    @IBAction func changeUserName(_ sender: Any) {
        currentPlayer = nil
        UserDefaults.standard.removeObject(forKey: "player")
        playerNameInput.isHidden = false
        playerName.text = ""
//        let vc = self.storyboard!.instantiateViewController(withIdentifier:"mainScreen")
//        self.navigationController!.setViewControllers([vc], animated: true)
    }
    
//    @objc func closeKeyboard() {
//        view.endEditing(true)
//    }
    
}

