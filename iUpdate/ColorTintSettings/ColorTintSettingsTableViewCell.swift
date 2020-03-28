//
//  ColorTintSettingsTableViewCell.swift
//  iUpdate
//
//  Created by pook on 3/28/20.
//  Copyright © 2020 pook. All rights reserved.
//

import UIKit

class ColorTintSettingsTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var colorImage: UIImageView!
    @IBOutlet weak var colorName: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
