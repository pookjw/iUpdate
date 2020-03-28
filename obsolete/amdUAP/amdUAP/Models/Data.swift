//
//  Data.swift
//  amdUAP
//
//  Created by pook on 11/8/19.
//  Copyright © 2019 pook. All rights reserved.
//

import Foundation

final class UserData: ObservableObject{
    @Published var asset: AssetData?
    @Published var documentation: Documentation?
    
    @Published var showSheet_1 = false
    @Published var showSheet_2 = false
    @Published var showAlert_1 = false
    @Published var showAlert_2 = false
    @Published var alertMessage = ""
    @Published var showDocumentationOnly = false
    @Published var disableDescription = false
    
    @Published var selectedAsset = 0
    @Published var catalog_url = [
        "iOS13DeveloperSeed",
        "iOS13PublicSeed"
    ]
}

