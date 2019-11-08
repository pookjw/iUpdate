//
//  Data.swift
//  amdUAP
//
//  Created by pook on 11/8/19.
//  Copyright © 2019 pook. All rights reserved.
//

import Foundation

struct xmlData: Codable{
    
    struct Key: Codable, Hashable{
        var Build: String
        var OSVersion: String
        var SupportedDeviceModels: [String]
        var SupportedDevices: [String]
        /*
        var PrerequisiteBuild: String?
        var __BaseURL: String
        var __RelativePath: String*/
    }
    
    var Assets: [Key]
}

final class UserData: ObservableObject{
    @Published var data: xmlData?
}
