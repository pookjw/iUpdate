//
//  ContentView.swift
//  amdUAP
//
//  Created by pook on 11/8/19.
//  Copyright © 2019 pook. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    
    var navigationButton_trailing: some View{
        HStack{
            Button(action: {self.userData.showSheet_1.toggle()}){
                Image(systemName: "gear")
            }
            Button(action: {
                var errorOccured = false
                
                self.userData.asset = nil
                self.userData.documentation = nil
                
                do{
                    if fileExists(url: cachesDirectory.appendingPathComponent("asset.plist")){
                        try removeItem(url: cachesDirectory.appendingPathComponent("asset.plist"))
                    }
                    if fileExists(url: cachesDirectory.appendingPathComponent("documentation.plist")){
                        try removeItem(url: cachesDirectory.appendingPathComponent("documentation.plist"))
                    }
                    
                    DownlondFromUrl(destinationFileUrl: cachesDirectory.appendingPathComponent("asset.plist"), url: getFullURL(type: .asset, name: self.userData.catalog_url[self.userData.selectedAsset]))
                    DownlondFromUrl(destinationFileUrl: cachesDirectory.appendingPathComponent("documentation.plist"), url: getFullURL(type: .documentation, name: self.userData.catalog_url[self.userData.selectedAsset]))
                    
                    while true{
                        if fileExists(url: cachesDirectory.appendingPathComponent("asset.plist")){
                            try self.userData.asset = load(url: cachesDirectory.appendingPathComponent("asset.plist"))
                            break
                        }
                    }
                    while true{
                        if fileExists(url: cachesDirectory.appendingPathComponent("documentation.plist")){
                            try self.userData.documentation = load(url: cachesDirectory.appendingPathComponent("documentation.plist"))
                            break
                        }
                    }
                }catch{
                    self.userData.showAlert_1 = true
                    errorOccured = true
                    self.userData.alertMessage = "\(error)"
                }
                
                if !errorOccured{
                    self.userData.showAlert_1 = true
                    self.userData.alertMessage = "Loaded!"
                }
            }){
                Image(systemName: "arrow.clockwise")
            }
            
        }
    }
    
    var alert: Alert{
        Alert(title: Text("Result"),
              message: Text(self.userData.alertMessage),
              dismissButton: .default(Text("Dismiss")
            )
        )
    }
    
    var body: some View {
        
        NavigationView{
            List{
                if self.userData.showDocumentationOnly {
                    if self.userData.documentation != nil{
                        ForEach(0..<self.userData.documentation!.Assets.count, id: \.self){ value in
                            //Text(String("\(value) \(self.userData.documentation!.Assets[value].Device)"))
                            NavigationLink(destination: DocumentationView(documentation_index: value)){
                                Image(systemName: "gear")
                                     .foregroundColor(Color.blue)
                                Text("\(self.userData.documentation!.Assets[value].Device)_\(self.userData.documentation!.Assets[value].OSVersion)_\(self.userData.documentation!.Assets[value].SUDocumentationID)")
                            }
                        }
                    }
                }else{
                    if self.userData.asset != nil {
                        ForEach(0..<self.userData.asset!.Assets.count, id: \.self){ value in
                            NavigationLink(destination: DocumentationView(asset_index: value)){
                                Image(systemName: "gear")
                                    .foregroundColor(Color.blue)
                                Text("\(self.userData.asset!.Assets[value].SupportedDevices[0])_\(self.userData.asset!.Assets[value].OSVersion)_\(self.userData.asset!.Assets[value].Build) (\(self.userData.asset!.Assets[value].SUDocumentationID))")
                            }
                            
                        }
                    }
                }
            }
            .sheet(isPresented: $userData.showSheet_1){
                SettingsView()
                    .environmentObject(self.userData)
            }
            .alert(isPresented: $userData.showAlert_1, content: {alert})
            .navigationBarTitle("Assets")
            .navigationBarItems(trailing: navigationButton_trailing)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
