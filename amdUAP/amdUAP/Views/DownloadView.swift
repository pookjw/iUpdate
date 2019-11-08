//
//  DownloadView.swift
//  amdUAP
//
//  Created by pook on 11/8/19.
//  Copyright © 2019 pook. All rights reserved.
//

import SwiftUI

struct DownloadView: View {
    @EnvironmentObject var userData: UserData
    
    func dateName() -> String{
        let dataformatter = DateFormatter()
        dataformatter.dateFormat = "yyyy_MM_dd_HH_mm_ss"
        return dataformatter.string(from: Date())
    }
    
    var body: some View {
        List{
            ForEach(assets_url.keys.sorted(), id: \.self){value in
                Button(action: {DownlondFromUrl(name: self.dateName(), url: assets_url[value]!)}){
                    Text(value)
                }
            }
        }
        .navigationBarTitle(Text("Download"))
    }
}

struct DownloadView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadView()
    }
}
