//
//  SelectCatalogView.swift
//  amdUAP
//
//  Created by pook on 11/8/19.
//  Copyright © 2019 pook. All rights reserved.
//

import SwiftUI

struct SelectCatalogView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        List{
            ForEach(0..<self.userData.catalog_url.count, id: \.self){value in
                Button(action: {self.userData.selectedAsset = value}){
                    HStack{
                        if self.userData.selectedAsset == value{
                            Image(systemName: "checkmark.square.fill")
                                .foregroundColor(Color.blue)
                                .frame(width: 30)
                        }else{
                            Image(systemName: "square")
                                .foregroundColor(Color.gray)
                                .frame(width: 30)
                        }
                        Text(self.userData.catalog_url[value])
                    }
                }
            }
        }
        .navigationBarTitle(Text("Catalog"), displayMode: .inline)
    }
}

struct SelectCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCatalogView()
    }
}
