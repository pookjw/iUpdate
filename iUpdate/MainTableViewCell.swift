//
//  MainTableViewCell.swift
//  iUpdate
//
//  Created by pook on 3/28/20.
//  Copyright © 2020 pook. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var updateName: UILabel!
    @IBOutlet weak var documentationID: UILabel!
    @IBOutlet weak var updateImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
