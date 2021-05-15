//
//  GiftTableViewCell.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 15/5/2564 BE.
//

import UIKit

class GiftTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var coinImg: UIImageView!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var collectButton: UIButton!
    @IBOutlet weak var numberOfTaskLabel: UILabel!
    @IBOutlet weak var taskDoneLabel: UILabel!
    @IBOutlet weak var backSlashLabel: UILabel!
    @IBOutlet weak var numberOfgiftLabel: UILabel!
    @IBOutlet weak var inProgressLabel: UILabel!
    
    var collectButtonAction : (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
