//
//  FileManager.swift
//  iUpdate
//
//  Created by pook on 3/30/20.
//  Copyright © 2020 pook. All rights reserved.
//

import Foundation

// Check directory exists from https://gist.github.com/brennanMKE/a0a2ee6aa5a2e2e66297c580c4df0d66
extension FileManager {
    func directoryExistsAtPath(atPath: String) -> Bool {
        var isDirectory = ObjCBool(true)
        let exists = FileManager.default.fileExists(atPath: atPath, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
}
