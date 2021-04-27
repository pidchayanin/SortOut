//
//  BetterShopTableViewCell.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 27/4/2564 BE.
//

import UIKit

class BetterShopTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemNumLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var coinImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
