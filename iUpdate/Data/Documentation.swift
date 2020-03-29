//
//  Documentation.swift
//  iUpdate
//
//  Created by pook on 3/29/20.
//  Copyright © 2020 pook. All rights reserved.
//

import Foundation

struct Documentation: Codable{
    struct Key: Codable, Hashable{
        var Device: String
        var OSVersion: String
        var SUDocumentationID: String
        var __BaseURL: String
        var __RelativePath: String
    }
    
    var Assets: [Key]
}
