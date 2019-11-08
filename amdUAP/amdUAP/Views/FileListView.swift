//
//  FileListView.swift
//  amdUAP
//
//  Created by pook on 11/8/19.
//  Copyright © 2019 pook. All rights reserved.
//

import SwiftUI

struct FileListView: View {
    @EnvironmentObject var userData: UserData
    @State var list = listFile()
    
    var navigationBarButton: some View{
        HStack{
            Button(action: {self.userData.showSheet_1.toggle()}){
                Image(systemName: "xmark")
            }
        }
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(0..<list.count, id: \.self){ value in
                    Text(self.list[value].path)
                }
            }
            .navigationBarItems(trailing: navigationBarButton)
            .navigationBarTitle(Text("Assets List"))
        }
    }
}

struct FileListView_Previews: PreviewProvider {
    static var previews: some View {
        FileListView()
    }
}
