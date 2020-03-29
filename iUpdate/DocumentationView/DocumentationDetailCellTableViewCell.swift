//
//  DocumentationDetailCellTableViewCell.swift
//  iUpdate
//
//  Created by pook on 3/30/20.
//  Copyright © 2020 pook. All rights reserved.
//

import UIKit

class DocumentationDetailCellTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var value: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }

}
