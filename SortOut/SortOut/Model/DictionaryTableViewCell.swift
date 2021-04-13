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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
