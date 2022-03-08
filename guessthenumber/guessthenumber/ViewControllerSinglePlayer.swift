//
//  ViewControllerSinglePlayer.swift
//  guessthenumber
//
//  Created by istiklal on 23.02.2022.
//


import UIKit

class ViewControllerSinglePlayer: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    

    var currentPlayer : String? = nil
    var maxScore = 0
    var currentGameScore = 1000
    private var machinesNumber : [Int]? = nil
    private var guessList = [Guess]()
    
    @IBOutlet weak var guessResultsTable: UITableView!
    //var guessList = [String]()  // initialize it with empty string array in here ..
    
    @IBOutlet weak var numberInput1: UITextField!
    @IBOutlet weak var numberInput2: UITextField!
    @IBOutlet weak var numberInput3: UITextField!
    @IBOutlet weak var numberInput4: UITextField!
    @IBOutlet weak var scoreText: UILabel!
    
    
    var chosenGuess : Guess?
    var chosenGuessOrder : Int = 0
    
//    var winnerAlert : UIAlertController
//    var quitButton : UIAlertAction
//    var playAgainButton : UIAlertAction
    
    private func registerTableViewCells() {
        let rowForGuessResults = UINib(nibName: "GuessListRowTableViewCell", bundle: nil)
        self.guessResultsTable.register(rowForGuessResults, forCellReuseIdentifier: "GuessListRowTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.guessList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentGuessObject : Guess = guessList[indexPath.row]
        
        if let cell = guessResultsTable.dequeueReusableCell(withIdentifier: "GuessListRowTableViewCell") as? GuessListRowTableViewCell {
            cell.guess_counter_title.text = String(indexPath.row + 1)
            cell.guess_number_title.text = String(currentGuessObject.number)
            cell.guess_in_place_title.text = String(currentGuessObject.inPlace)
            cell.guess_not_in_place_title.text = String(currentGuessObject.notInPlace)
            cell.guess_score_title.text = " - " + String(currentGuessObject.score)
            return cell
        }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = String(currentGuessObject.number) + " - " + String(currentGuessObject.inPlace) + " - " + String(currentGuessObject.notInPlace) + " - " + String(currentGuessObject.score)
        return cell
    }
    
    // this method let us remove a row in table view
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            self.guessList.remove(at: indexPath.row)
//            guessResultsTable.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
//        }
//    }
//
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // chosenGuess = String(guessList[indexPath.row].number)
        chosenGuessOrder = indexPath.row
        chosenGuess = guessList[indexPath.row]
        performSegue(withIdentifier: "toGuessDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGuessDetailsVC" {
            let destinationVC = segue.destination as! ViewControllerGuessDetails
            destinationVC.order = String(chosenGuessOrder)
            destinationVC.chosenGuess = chosenGuess
        }
    }
    
    @IBAction func makeNewGuess(_ sender: Any) {
        
        let alerTitleText = "YOU ARE THE WINNER"
        var alertMessageText = "WOW Avesome !! You won with score "
        
        let inputList = [numberInput1.text, numberInput2.text, numberInput3.text, numberInput4.text]
        let inputSet = Set(inputList)
        if inputList.contains("") {
            // there is a missing digit ..
            print("istiklal [ViewControllerSinglePlayer.makeNewGuess] WARNING ", " THERE ARE MISSING DIGITS : \(inputList)")
        } else if inputList[0] == "0" {
            // number sgarts with zero, that's not a 4 digit number ..
            print("istiklal [ViewControllerSinglePlayer.makeNewGuess] WARNING ", " 4 DIGIT NUMBER CAN NOT STARTS WITH 0 : \(inputList)")
        } else if inputSet.count < 4 {
            // there are repeating numbers ..
            print("istiklal [ViewControllerSinglePlayer.makeNewGuess] WARNING ", " THERE ARE REPEATING NUMBERS IN YOUR GUESS : \(inputList)")
        } else {
            let newlyGuessedDigits = [Int](inputList.map { Int(String($0!))! })
            print("istiklal [ViewControllerSinglePlayer.makeNewGuess] ", " Your new guess : \(newlyGuessedDigits)")
            let userGuessAttempt = Guess(digitList: newlyGuessedDigits, numberToGuess: machinesNumber!, guessCount: guessList.count + 1)
            currentGameScore -= userGuessAttempt.score
            scoreText.text = String(currentGameScore)
            guessList.append(userGuessAttempt)
            guessResultsTable.reloadData()
            scrollToBottom()
            numberInput1.text = ""
            numberInput2.text = ""
            numberInput3.text = ""
            numberInput4.text = ""
            if userGuessAttempt.isWinner() {
                print("istiklal [ViewControllerSinglePlayer.makeNewGuess] INFO ", " You hit the right number \(String(userGuessAttempt.number)) with score \(currentGameScore)")
                if self.maxScore == 0 || self.currentGameScore > self.maxScore {
                    self.maxScore = self.currentGameScore
                    UserDefaults.standard.set(self.maxScore, forKey: "maxScore")
                    alertMessageText = "WOW Avesome !! Your new max score is "
                }
                self.prepareForWinnerAlert(titleText: alerTitleText, MessageText: alertMessageText + String(currentGameScore))
                
            }
            numberInput1.becomeFirstResponder()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("istiklal [ViewControllerSinglePlayer.viewDidLoad] ", " called")
        // refresh button
//        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh , target: self, action: #selector(restartGame))
        
        guessResultsTable.delegate = self
        guessResultsTable.dataSource = self
        self.registerTableViewCells()
        
        // keyboard hiding operation (tapGesture)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        // text fields control operations, not completed yet .................................. continue to research to limit chars count in it
        numberInput1.delegate = self
        numberInput2.delegate = self
        numberInput3.delegate = self
        numberInput4.delegate = self
        
        if self.currentPlayer == nil {
            if let savedPlayer = UserDefaults.standard.object(forKey : "player") as? String {
                self.currentPlayer = savedPlayer
            }
        }
        print("istiklal [ViewControllerSinglePlayer.viewDidLoad] ", " currentPlayer : \(String(describing: currentPlayer))")
        
        if machinesNumber == nil {
            machinesNumber = MachineNumberGenerator.pickNumber()
        }
        
        print("istiklal [ViewControllerSinglePlayer.viewDidLoad] ", " machinesNumber : \(String(describing: machinesNumber))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("istiklal [ViewControllerSinglePlayer.viewWillAppear] ", " called")
        if let savedMaxScore = UserDefaults.standard.object(forKey: "maxScore") as? Int {
            self.maxScore = savedMaxScore
        }
        scoreText.text = String(currentGameScore)
        numberInput1.becomeFirstResponder()

//        guessList.append(Guess(digitList: [4, 2, 6, 5], numberToGuess: machinesNumber!, guessCount: 1))
//        guessList.append(Guess(digitList: [1, 2, 3, 4], numberToGuess: machinesNumber!, guessCount: 2))
//        guessList.append(Guess(digitList: [5, 6, 7, 8], numberToGuess: machinesNumber!, guessCount: 3))
//        guessList.append(Guess(digitList: [9, 0, 1, 2], numberToGuess: machinesNumber!, guessCount: 4))
//        guessList.append(Guess(digitList: [3, 4, 5, 6], numberToGuess: machinesNumber!, guessCount: 5))
//        guessList.append(Guess(digitList: [7, 8, 1, 2], numberToGuess: machinesNumber!, guessCount: 6))

    }
    
    @objc func restartGame() {
        print("istiklal [ViewControllerSinglePlayer.resfreshButtonAction] called .. ")
        self.machinesNumber = MachineNumberGenerator.pickNumber()
        self.currentGameScore = 1000
        self.scoreText.text = String(self.currentGameScore)
        self.guessList.removeAll()
        self.guessResultsTable.reloadData()
        self.numberInput1.becomeFirstResponder()
    }
    
    @objc func closeKeyboard () {
        view.endEditing(true)
    }
    
    func prepareForWinnerAlert(titleText : String, MessageText : String) {
        let winnerAlert = UIAlertController(title: titleText, message: MessageText, preferredStyle: .alert)
        let quitButton = UIAlertAction(title : "Quit", style : UIAlertAction.Style.destructive) { UIAlertAction in
            // quit game and return to game selection view controller scene ..
            self.navigationController?.popViewController(animated: true)
        }
        let playAgainButton = UIAlertAction(title : "Play Again", style: .default) { UIAlertAction in
            // restart this activity
            self.restartGame()
        }
        winnerAlert.addAction(quitButton)
        winnerAlert.addAction(playAgainButton)
        present(winnerAlert, animated: true, completion: nil)
    }
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.guessList.count-1, section: 0)
            self.guessResultsTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
}
