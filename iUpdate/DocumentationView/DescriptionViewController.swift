//
//  DescriptionViewController.swift
//  iUpdate
//
//  Created by pook on 3/29/20.
//  Copyright © 2020 pook. All rights reserved.
//

import SSZipArchive
import UIKit
import WebKit

class DescriptionViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    
    //MARK: Properties
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var wkWebView: WKWebView!
    var documentation_url: String?
    var documentation_id: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = self.documentation_id!
        do {
            try self.getDescription()
        } catch {
            fatalError("\(error)")
        }
        
        self.sendRequest()
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
    private func sendRequest() {
        let fileManager = FileManager()
        var description_html_url = fileManager.temporaryDirectory
        description_html_url.appendPathComponent("description/AssetData/en.lproj/ReadMeSummary.html")
        let myRequest = URLRequest(url: description_html_url)
        wkWebView.load(myRequest)
    }
    
    private func getDescription() throws {
        // Get Description Zip file
        let fileManager = FileManager()
        
        var description_zip_url = fileManager.temporaryDirectory
        description_zip_url.appendPathComponent("description.zip")
        
        if fileManager.fileExists(atPath: description_zip_url.path) {
            try fileManager.removeItem(at: description_zip_url)
        }
        
        let description_zip_data = try Data(contentsOf: URL(string: self.documentation_url!)!)
        try description_zip_data.write(to: description_zip_url)
        
        // Unzip
        var description_dir = fileManager.temporaryDirectory
        description_dir.appendPathComponent("description")
        
        if fileManager.directoryExistsAtPath(atPath: description_dir.path) {
            try fileManager.removeItem(at: description_dir)
        }
        SSZipArchive.unzipFile(atPath: description_zip_url.path, toDestination: description_dir.path)
    }
}
