//
//  TrackingCellTableViewCell.swift
//  OTWL Tracker
//
//  Created by Sanjay Mali on 15/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit

class TrackingCellTableViewCell: UITableViewCell {
    @IBOutlet weak var Job_Id: UILabel!
    @IBOutlet weak var Customer: UILabel!
    @IBOutlet weak var OA_Coloader_Courier: UILabel!
    @IBOutlet weak var SL_AL: UILabel!
    @IBOutlet weak var Port_Info: UILabel!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var notificationBackgroundView: UIView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var round1: UIView!
    @IBOutlet weak var round2: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var POD_Time: UILabel!
    @IBOutlet weak var POL_Time: UILabel!
    @IBOutlet weak var POD: UILabel!
    @IBOutlet weak var POL: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
