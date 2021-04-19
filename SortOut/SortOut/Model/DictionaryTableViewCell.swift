//
//  DictionaryTableViewCell.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 13/4/2564 BE.
//

import UIKit

class DictionaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var partOfSpeechLabel: UILabel!
    @IBOutlet weak var addToVocabListButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var addedTextLabel: UILabel!
    @IBOutlet weak var addToListLabel: UILabel!
    
    
    var addToVocabListButtonAction : (() -> ())?
    var undoButtonAction : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addToVocabListButton.addTarget(self, action: #selector(buyButtonTapped(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buyButtonTapped(_ sender: UIButton){
        // if the closure is defined (not nil)
        // then execute the code inside the subscribeButtonAction closure
        addToVocabListButtonAction?()
      }
    @IBAction func undoTapped(_ sender: Any) {
        undoButtonAction?()
    }
}
