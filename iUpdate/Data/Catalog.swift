//
//  Catalog.swift
//  iUpdate
//
//  Created by pook on 3/23/20.
//  Copyright © 2020 pook. All rights reserved.
//

import UIKit

class Catalog {
    var name: String
    var assets_url: String
    var documentation_url: String
    
    init(name: String, assets_url: String, documentation_url: String){
        self.name = name
        self.assets_url = assets_url
        self.documentation_url = documentation_url
    }
}
