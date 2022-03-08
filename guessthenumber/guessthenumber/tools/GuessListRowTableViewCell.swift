//
//  GuessListRowTableViewCell.swift
//  guessthenumber
//
//  Created by BTK on 4.03.2022.
//


import UIKit

class GuessListRowTableViewCell: UITableViewCell {

    @IBOutlet weak var guess_counter_title: UILabel!
    @IBOutlet weak var guess_number_title: UILabel!
    @IBOutlet weak var guess_in_place_title: UILabel!
    @IBOutlet weak var guess_not_in_place_title: UILabel!
    @IBOutlet weak var guess_score_title: UILabel!
    
    var counter : String = ""
    var number : String = ""
    var inPlace : String = ""
    var notInPlace : String = ""
    var score : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        guess_counter_title.text = counter
//        guess_number_title.text = number
//        guess_in_place_title.text = inPlace
//        guess_not_in_place_title.text = notInPlace
//        guess_score_title.text = score
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
