//
//  Assets.swift
//  amdUAP
//
//  Created by pook on 11/8/19.
//  Copyright © 2019 pook. All rights reserved.
//

import Foundation

struct AssetsData: Codable{
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

let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]

func load<T: Decodable>(url: URL) throws -> T {
    let data: Data
    data = try Data(contentsOf: url)
    let decoder = PropertyListDecoder()
    return try decoder.decode(T.self, from: data)
}

enum DataType{
    case asset, documentation
}

func getFullURL(type: DataType, name: String) -> String{
    switch type{
    case .asset:
        print("https://mesu.apple.com/assets/" + name + "/com_apple_MobileAsset_SoftwareUpdate/com_apple_MobileAsset_SoftwareUpdate.xml")
        return "https://mesu.apple.com/assets/" + name + "/com_apple_MobileAsset_SoftwareUpdate/com_apple_MobileAsset_SoftwareUpdate.xml"
    case .documentation:
        return "https://mesu.apple.com/assets/" + name + "/com_apple_MobileAsset_SoftwareUpdateDocumentation/com_apple_MobileAsset_SoftwareUpdateDocumentation.xml"
    }
}


func fileExists(url: URL) -> Bool{
    var isDirectory = ObjCBool(true)
    let exists = FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory)
    return !isDirectory.boolValue && exists
}

func directoryExists(url: URL) -> Bool{
    var isDirectory = ObjCBool(true)
    let exists = FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory)
    return isDirectory.boolValue && exists
}

func removeItem(url: URL) throws{
    try FileManager.default.removeItem(at: url)
}
    

func DownlondFromUrl(destinationFileUrl : URL, url: String){ // https://stackoverflow.com/a/51442174
    //Create URL to the source file you want to download
    let fileURL = URL(string: url)
    
    let sessionConfig = URLSessionConfiguration.default
    let session = URLSession(configuration: sessionConfig)
    
    let request = URLRequest(url:fileURL!)
    
    let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
        if let tempLocalUrl = tempLocalUrl, error == nil {
            // Success
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                print("Successfully downloaded. Status code: \(statusCode)")
            }
            
            do {
                try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
            } catch (let writeError) {
                print("Error creating a file \(destinationFileUrl): \(writeError)")
            }
            
        } else {
            print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
        }
    }
    task.resume()
}
