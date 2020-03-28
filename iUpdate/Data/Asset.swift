//
//  Asset.swift
//  iUpdate
//
//  Created by pook on 3/23/20.
//  Copyright © 2020 pook. All rights reserved.
//

import Foundation

struct Asset: Codable{
    struct Key: Codable, Hashable{
        var Build: String
        var OSVersion: String
        var PrerequisiteBuild: String?
        var PrerequisiteOSVersion: String?
        var SUDocumentationID: String
        var SupportedDeviceModels: [String]
        var SupportedDevices: [String]
        var __BaseURL: String
        var __RelativePath: String
    }
    var Assets: [Key]
}
