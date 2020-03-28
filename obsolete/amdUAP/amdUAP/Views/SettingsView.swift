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
                Spacer()
                    .frame(width: 50)
                Image(systemName: "xmark")
            }
        }
    }
    
    var body: some View {
        NavigationView{
            List{
                NavigationLink(destination: SelectCatalogView()){
                    Image(systemName: "doc.richtext")
                        .foregroundColor(Color.blue)
                        .frame(width: 30)
                    Text("Select Catalog")
                }
                Toggle(isOn: $userData.showDocumentationOnly){
                    Image(systemName: "doc.text")
                        .foregroundColor(Color.blue)
                        .frame(width: 30)
                    Text("Show Documentation on List")
                }
                Toggle(isOn: $userData.disableDescription){
                    Image(systemName: "doc")
                        .foregroundColor(Color.blue)
                        .frame(width: 30)
                    Text("Disable Description")
                }
                Text(cachesDirectory.path)
            }
            .navigationBarItems(trailing: navigationBarButton_trailing)
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
