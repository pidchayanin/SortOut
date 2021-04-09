//
//  ShopTableViewCell.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 18/2/2564 BE.
//

import UIKit

class ShopTableViewCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var numberOfItemLabel: UILabel!
    
    var buyButtonAction : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.buyButton.addTarget(self, action: #selector(buyButtonTapped(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buyButtonTapped(_ sender: UIButton){
        // if the closure is defined (not nil)
        // then execute the code inside the subscribeButtonAction closure
        buyButtonAction?()
      }

}
