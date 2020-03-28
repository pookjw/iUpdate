//
//  AddCatalogTableViewCell.swift
//  iUpdate
//
//  Created by pook on 3/29/20.
//  Copyright © 2020 pook. All rights reserved.
//

import UIKit

class AddCatalogTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var value: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }

}
