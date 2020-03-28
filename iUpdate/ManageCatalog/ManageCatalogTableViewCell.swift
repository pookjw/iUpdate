//
//  ManageCatalogTableViewCell.swift
//  iUpdate
//
//  Created by pook on 3/23/20.
//  Copyright © 2020 pook. All rights reserved.
//

import UIKit

class ManageCatalogTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var catalogImage: UIImageView!
    @IBOutlet weak var catalogLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }

}
