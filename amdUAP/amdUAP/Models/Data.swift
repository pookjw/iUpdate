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
}
