//
//  SettingsTableViewCell.swift
//  iUpdate
//
//  Created by pook on 3/28/20.
//  Copyright © 2020 pook. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var settingsImage: UIImageView!
    @IBOutlet weak var settingsTitle: UILabel!
    @IBOutlet weak var settingsDescription: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(true, animated: animated)

        // Configure the view for the selected state
    }

}
