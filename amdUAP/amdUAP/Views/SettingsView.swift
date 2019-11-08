//
//  SettingsView.swift
//  amdUAP
//
//  Created by pook on 11/8/19.
//  Copyright © 2019 pook. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userData: UserData
    
    var navigationBarButton_trailing: some View{
        HStack{
            Button(action: {self.userData.showSheet_1.toggle()}){
                Image(systemName: "gear")
            }
        }
    }
    
    var body: some View {
        NavigationView{
            Text("Settings")
            .navigationBarItems(trailing: navigationBarButton_trailing)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
