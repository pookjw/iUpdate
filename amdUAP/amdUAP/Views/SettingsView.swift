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
                Image(systemName: "xmark")
            }
        }
    }
    
    var body: some View {
        NavigationView{
            List{
                NavigationLink(destination: SelectCatalogView()){
                    Text("Select Catalog")
                }
                Toggle(isOn: $userData.showDocumentationOnly){
                    Text("Show Documentation on List")
                }
                Button(action: {self.userData.data = nil}){
                    Text("Clear Loaded Data")
                        .foregroundColor(Color.blue)
                }
            }
            .navigationBarItems(trailing: navigationBarButton_trailing)
            .navigationBarTitle(Text("Settings"))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
