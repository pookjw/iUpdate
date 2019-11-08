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
            Button(action: {self.userData.showSheet_2.toggle()}){
                Image(systemName: "list.bullet")
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
            .sheet(isPresented: $userData.showSheet_2){
                FileListView()
                    .environmentObject(self.userData)
            }
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
