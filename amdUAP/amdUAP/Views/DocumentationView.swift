//
//  DocumentationView.swift
//  amdUAP
//
//  Created by pook on 11/18/19.
//  Copyright © 2019 pook. All rights reserved.
//

import SwiftUI
import ZipArchive

struct DocumentationView: View {
    @EnvironmentObject var userData: UserData
    
    init(asset_index: Int){
        self.asset_index = asset_index
    }
    
    var asset_index: Int?
    var documentation_index: Int {
        var return_value = -1
        for value in 0..<self.userData.documentation!.Assets.count{
            //print("\(value): \(self.userData.documentation!.Assets[value].SUDocumentationID)")
            if self.userData.documentation!.Assets[value].SUDocumentationID == self.userData.asset!.Assets[asset_index!].SUDocumentationID && self.userData.documentation!.Assets[value].Device == device {
                return_value = value
                break
            }
        }
        return return_value
    }
    
    var device: String {
        if asset_index != nil{
            switch self.userData.asset!.Assets[asset_index!].SupportedDevices[0]{
            case let value where value.contains("iPad"):
                return "iPad"
            case let value where value.contains("iPhone"):
                return "iPhone"
            case let value where value.contains("iPod"):
                return "iPod touch"
            default:
                return ""
            }
        } else {
            return self.userData.documentation!.Assets[asset_index!].Device
        }
    }
    
    var description: some View{
        do{
            
            if directoryExists(url: cachesDirectory.appendingPathComponent("documentation/\(documentation_index)")) || fileExists(url: cachesDirectory.appendingPathComponent("documentation/\(documentation_index)")){
                try removeItem(url: cachesDirectory.appendingPathComponent("documentation/\(documentation_index)"))
            }
            try createDirectory(url: cachesDirectory.appendingPathComponent("documentation/\(documentation_index)"))

            DownlondFromUrl(
                destinationFileUrl: cachesDirectory.appendingPathComponent("documentation/\(documentation_index)/file.zip"),
                url: self.userData.documentation!.Assets[documentation_index].__BaseURL + self.userData.documentation!.Assets[documentation_index].__RelativePath
            )
            
            while true{
                if fileExists(url: cachesDirectory.appendingPathComponent("documentation/\(documentation_index)/file.zip")){
                    SSZipArchive.unzipFile(
                        atPath: cachesDirectory.appendingPathComponent("documentation/\(documentation_index)/file.zip").path,
                        toDestination: cachesDirectory.appendingPathComponent("documentation/\(documentation_index)/data").path
                    )
                    break
                }
            }
            
            let text = try String(contentsOf: cachesDirectory.appendingPathComponent("documentation/\(documentation_index)/data/AssetData/en.lproj/ReadMeSummary.html"), encoding: .utf8)
            return WebView(text: text)
        }catch{
            print(error)
        }
        return WebView(text: "")
    }
    
    
    var body: some View {
        VStack{
            Image("iOS13")
                .resizable()
                .scaledToFit()
            Image("Settings")
                .resizable()
                .frame(width: 150, height: 150)
                .padding(.bottom, -75)
                .offset(y: -75)
            Text(self.userData.documentation!.Assets[documentation_index].SUDocumentationID)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
            
            description
            
            Spacer()
        }
        .navigationBarTitle("Update", displayMode: .inline)
    }
}

struct DocumentationView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentationView(asset_index: 0)
    }
}
