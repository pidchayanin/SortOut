//
//  VocablistTableViewCell.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 21/2/2564 BE.
//

import UIKit

class VocablistTableViewCell: UITableViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var partOfSpeechLabel: UILabel!
    @IBOutlet weak var meaningLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

protocol DeleteRowInTableviewDelegate: NSObjectProtocol {
    func deleteRow(inTableview rowToDelete: Int)
}
