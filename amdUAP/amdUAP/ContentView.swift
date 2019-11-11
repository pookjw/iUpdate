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
                self.userData.data = nil
                do{
                    try removeItem(url: cachesDirectory.appendingPathComponent("asset"))
                }catch (let removeError){
                    self.userData.showAlert_1 = true
                    errorOccured = true
                    self.userData.alertMessage = "Error removing a asset: \(removeError)"
                }
                DownlondFromUrl(destinationFileUrl: cachesDirectory.appendingPathComponent("asset"), url: getFullURL(type: .asset, name: self.userData.catalog_url[self.userData.selectedAsset]))
                do{
                    while true{
                         if fileExists(url: cachesDirectory.appendingPathComponent("asset")){
                            try self.userData.data = load(url: cachesDirectory.appendingPathComponent("asset"))
                            break
                        }
                    }
                } catch {
                    self.userData.showAlert_1 = true
                    errorOccured = true
                    self.userData.alertMessage = "Error parsing a asset: \(error)"
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
                if self.userData.data != nil {
                    ForEach(self.userData.data!.Assets, id: \.self){ value in
                        HStack{
                            Image(systemName: "gear")
                                .foregroundColor(Color.blue)
                            Text("\(value.SupportedDevices[0])_\(value.OSVersion)_\(value.Build)")
                        }
                        
                    }
                }
            }
            .sheet(isPresented: $userData.showSheet_1){
                SettingsView()
                    .environmentObject(self.userData)
            }
            .alert(isPresented: $userData.showAlert_1, content: {alert})
            .navigationBarTitle(Text("Updates"), displayMode: .inline)
            .navigationBarItems(trailing: navigationButton_trailing)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
