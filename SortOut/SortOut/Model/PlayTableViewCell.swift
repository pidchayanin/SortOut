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
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    private func setupCell() {
        containerView.backgroundColor = UIColor.white
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        containerView.backgroundColor = .white
    }

}
