//
//  DictionaryTableViewCell.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 13/4/2564 BE.
//

import UIKit

protocol DictCellDelegate : class {
    func  didPressButton(_ tag: Int)
}

class DictionaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var partOfSpeechLabel: UILabel!
    @IBOutlet weak var addToVocabListButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var meaningInThaiLabel: UILabel!
    @IBOutlet weak var definitionInThaiLabel: UILabel!
    @IBOutlet weak var synnonymLabel: UILabel!
    @IBOutlet weak var synnonymWordLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    @IBOutlet weak var exampleSentenceLabel: UILabel!
    
    var cellDelegate: DictCellDelegate?
    
    var addToVocabListButtonAction : (() -> ())?
    var undoButtonAction : (() -> ())?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addToVocabListButton.addTarget(self, action: #selector(buyButtonTapped(_:)), for: .touchUpInside)
        self.undoButton.addTarget(self, action: #selector(undoTapped(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /*override func prepareForReuse() {
        self.addToVocabListButton.isHidden = true
    }*/
    
    @IBAction func buyButtonTapped(_ sender: UIButton){
        // if the closure is defined (not nil)
        // then execute the code inside the subscribeButtonAction closure
        addToVocabListButtonAction?()
        cellDelegate?.didPressButton(sender.tag)
      }
    
    
    
    @IBAction func undoTapped(_ sender: UIButton) {
        undoButtonAction?()
    }
}
