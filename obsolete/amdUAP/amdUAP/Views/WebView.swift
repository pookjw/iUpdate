//
//  WebView.swift
//  amdUAP
//
//  Created by pook on 11/18/19.
//  Copyright © 2019 pook. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable{
    let text: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(text, baseURL: nil)
    }
}
