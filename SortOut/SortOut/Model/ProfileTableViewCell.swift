//
//  ProfileTableViewCell.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 19/2/2564 BE.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var notiOnSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
