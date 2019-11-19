//
//  DetailView.swift
//  amdUAP
//
//  Created by pook on 11/19/19.
//  Copyright © 2019 pook. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var userData: UserData
    var asset_index: Int?
    var documentation_index: Int?
    
    var navigationBarButton_trailing: some View{
        HStack{
            Button(action: {self.userData.showSheet_2.toggle()}){
                Spacer()
                    .frame(width: 50)
                Image(systemName: "xmark")
            }
        }
    }
    
    var alert: Alert{
        Alert(title: Text("Alert"),
              message: Text("Copied to clipboard!"),
              dismissButton: .default(Text("Dismiss")
            )
        )
    }
    
    var dict: [String: String?] {
        if asset_index != nil {
            return [
                "Build": self.userData.asset!.Assets[asset_index!].Build,
                "OSVersion": self.userData.asset!.Assets[asset_index!].OSVersion,
                "PrerequisiteBuild": self.userData.asset!.Assets[asset_index!].PrerequisiteBuild,
                "PrerequisiteOSVersion": self.userData.asset!.Assets[asset_index!].PrerequisiteOSVersion,
                "SUDocumentationID": self.userData.asset!.Assets[asset_index!].SUDocumentationID,
                "SupportedDeviceModels": self.userData.asset!.Assets[asset_index!].SupportedDeviceModels[0],
                "SupportedDevices": self.userData.asset!.Assets[asset_index!].SupportedDevices[0],
                "BaseURL": self.userData.asset!.Assets[asset_index!].__BaseURL,
                "RelativePath": self.userData.asset!.Assets[asset_index!].__RelativePath,
                "FullURL": self.userData.asset!.Assets[asset_index!].__BaseURL + self.userData.asset!.Assets[asset_index!].__RelativePath
            ]
        } else if documentation_index != nil {
            return [
                "Device": self.userData.documentation!.Assets[documentation_index!].Device,
                "OSVersion": self.userData.documentation!.Assets[documentation_index!].OSVersion,
                "SUDocumentationID": self.userData.documentation!.Assets[documentation_index!].SUDocumentationID,
                "BaseURL": self.userData.documentation!.Assets[documentation_index!].__BaseURL,
                "RelativePath": self.userData.documentation!.Assets[documentation_index!].__RelativePath,
                "FullURL": self.userData.documentation!.Assets[documentation_index!].__BaseURL + self.userData.documentation!.Assets[documentation_index!].__RelativePath
            ]
        }
        return ["Alert!": "This view requires asset_index or documentation_index. Try again!"]
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(dict.keys.sorted(), id: \.self){ value in
                    Button(action: {
                        if self.dict[value]! != nil {
                            UIPasteboard.general.string = self.dict[value]!
                        } else {
                            UIPasteboard.general.string = "nil"
                        }
                        self.userData.showAlert_2.toggle()
                    }){
                        HStack{
                            Text(value)
                            Spacer()
                            if self.dict[value]! == nil {
                                Text("nil")
                                    .foregroundColor(Color.gray)
                            } else {
                                Text(self.dict[value]!!)
                                    .foregroundColor(Color.gray)
                            }
                        }
                    }
                }
            }
            .alert(isPresented: $userData.showAlert_2, content: {alert})
            .navigationBarTitle("Detail", displayMode: .inline)
            .navigationBarItems(trailing: navigationBarButton_trailing)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
