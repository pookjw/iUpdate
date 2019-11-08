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

let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

func load<T: Decodable>(url: URL) -> T {
    
    let data: Data
    
    do {
        data = try Data(contentsOf: url)
    } catch {
        fatalError("Couldn't load \(url.path): \(error)")
    }
    
    do {
        let decoder = PropertyListDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(url.path): \(error)")
    }
}

func listFile() -> [URL]{
    do{
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("assets")
        let directoryContents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        return directoryContents.filter {!$0.hasDirectoryPath}
    }catch{
        print(error)
    }
    return []
}

func fileExists(url: URL) -> Bool{
    var isDirectory = ObjCBool(true)
    let exists = FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory)
    return isDirectory.boolValue && exists
}

func directoryExists(url: URL) -> Bool{
    var isDirectory = ObjCBool(true)
    let exists = FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory)
    return !isDirectory.boolValue && exists
}

func DownlondFromUrl(name: String, url: String){ // https://stackoverflow.com/a/51442174
    // Create destination URL
    let destinationFileUrl = documentsUrl.appendingPathComponent("assets/\(name)")
    
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
                print("Error creating a file \(destinationFileUrl) : \(writeError)")
            }
            
        } else {
            print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
        }
    }
    task.resume()
}
