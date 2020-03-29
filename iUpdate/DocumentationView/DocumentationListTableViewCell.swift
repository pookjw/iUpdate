//
//  DocumentationListTableViewCell.swift
//  iUpdate
//
//  Created by pook on 3/30/20.
//  Copyright © 2020 pook. All rights reserved.
//

import UIKit

class DocumentationListTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var documentationImage: UIImageView!
    @IBOutlet weak var documentationID: UILabel!
    @IBOutlet weak var device: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
