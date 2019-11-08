//
//  Data.swift
//  amdUAP
//
//  Created by pook on 11/8/19.
//  Copyright © 2019 pook. All rights reserved.
//

import Foundation

final class UserData: ObservableObject{
    @Published var data: AssetsData?
    @Published var showSheet_1 = false
    @Published var showSheet_2 = false
    @Published var urlRefreshMode = false
}

let assets_url = ["iOS13DeveloperSeed": "https://mesu.apple.com/assets/iOS13DeveloperSeed/com_apple_MobileAsset_SoftwareUpdate/com_apple_MobileAsset_SoftwareUpdate.xml"]
