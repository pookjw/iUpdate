//
//  UpdateDetailViewController.swift
//  iUpdate
//
//  Created by pook on 3/29/20.
//  Copyright © 2020 pook. All rights reserved.
//

import UIKit
import WebKit

class UpdateDetailViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var wkWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.sendRequest(urlString: "https://developer.apple.com/documentation/webkit/wkwebview/")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: Private Methods
    private func sendRequest(urlString: String) {
        let myURL = URL(string: urlString)
        let myRequest = URLRequest(url: myURL!)
        wkWebView.load(myRequest)
    }
}
