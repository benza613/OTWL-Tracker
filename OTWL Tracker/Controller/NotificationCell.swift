//
//  NotificationCell.swift
//  OceanWorld_Clearance
//
//  Created by Sanjay Mali on 07/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit
class NotificationCell: UITableViewCell {
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var notificationBackgroundView: UIView!
    @IBOutlet weak var notificationDescription: UILabel!
    @IBOutlet weak var NotificationTime: UILabel!
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
}


