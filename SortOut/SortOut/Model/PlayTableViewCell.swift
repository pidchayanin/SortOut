//
//  PlayTableViewCell.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 12/5/2564 BE.
//

import UIKit

class PlayTableViewCell: UITableViewCell {

    @IBOutlet weak var engSentenceLabel: UILabel!
    @IBOutlet weak var thSentenceLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
