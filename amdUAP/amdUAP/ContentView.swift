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
    
    var navigationButton: some View{
        HStack{
            Button(action: { DownlondFromUrl(url: "https://mesu.apple.com/assets/iOS13DeveloperSeed/com_apple_MobileAsset_SoftwareUpdate/com_apple_MobileAsset_SoftwareUpdate.xml") }){
                Text("Download")
            }
            Button(action: {self.userData.data = load()}){
                Text("Load")
            }
            Button(action: {self.userData.showSheet_1.toggle()}){
                Text("O")
            }
        }
    }
    
    var body: some View {
        /*
        VStack{
            Text("Hello, World!")
            if self.userData.data != nil{
            Text(self.userData.data!.SigningKey)
                Text(self.userData.data!.Assets[0].Build)
                Text(self.userData.data!.Assets[0].SupportedDeviceModels[0])
            }
            Button(action: { self.userData.data = load("iOS13DeveloperSeed.plist")}){
                Text("Button")
            }
        }*/
        NavigationView{
            List{
                if self.userData.data != nil {
                    ForEach(self.userData.data!.Assets, id: \.self){ value in
                        HStack{
                            Text("\(value.SupportedDevices[0])_\(value.OSVersion)_\(value.Build)")
                        }
                        
                    }
                }else{
                    Text("Click Button")
                }
            }
            .sheet(isPresented: $userData.showSheet_1){
                FileListView()
                    .environmentObject(self.userData)
            }
            .navigationBarTitle(Text("amdUAP"), displayMode: .inline)
            .navigationBarItems(trailing: navigationButton)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
