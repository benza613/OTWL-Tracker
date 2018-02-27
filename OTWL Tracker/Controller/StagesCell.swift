//
//  StagesCell.swift
//  OTWL Tracker
//
//  Created by Sanjay Mali on 15/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit

class StagesCell: UITableViewCell {
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var notificationBackgroundView: UIView!
    @IBOutlet weak var a1: UILabel!
    @IBOutlet weak var a2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
