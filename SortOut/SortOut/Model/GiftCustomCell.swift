//
//  GiftCustomCell.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 13/2/2564 BE.
//

import UIKit

class GiftCustomCell: UITableViewCell {
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myCellLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var collectButton: UIButton!
    
    var collectButtonAction : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
            
        // Add action to perform when the button is tapped
        self.collectButton.addTarget(self, action: #selector(collectButtonTapped(_:)), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func collectButtonTapped(_ sender: UIButton){
        // if the closure is defined (not nil)
        // then execute the code inside the subscribeButtonAction closure
        collectButtonAction?()
      }
}
