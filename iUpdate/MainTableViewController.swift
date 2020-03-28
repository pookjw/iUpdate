//
//  MainTableViewController.swift
//  iUpdate
//
//  Created by pook on 3/23/20.
//  Copyright © 2020 pook. All rights reserved.
//

import UIKit
import os.log

class MainTableViewController: UITableViewController {
    
    @IBAction func unwindToAssetList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ManageCatalogTableViewController {
            if let selected_catalog = sourceViewController.selected_catalog {
                self.catalog = sourceViewController.catalogs[selected_catalog]
                self.selected_catalog = selected_catalog
                self.titleButton.setTitle(self.catalog!.name, for: .normal)
                do{
                    try self.update()
                } catch {
                    fatalError("\(error)")
                }
            }
        }
    }
    
    //MARK: Properties
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var titleButton: UIButton!
    @IBAction func getData(_ sender: UIBarButtonItem) {
        do{
            if catalog != nil && selected_catalog != nil {
                try self.update()
            }
        } catch {
            fatalError("\(error)")
        }
    }
    
    var catalog: Catalog?
    var selected_catalog: Int?
    var asset: Asset? = nil
    var all_indexPath = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.titleButton.setTitle("(nil)", for: .normal)
        self.makeSettingsBtn()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let aseet = self.asset {
            return aseet.Assets.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MainTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MainTableViewCell else {
            fatalError("The dequeued cell is not an instance of MainTableViewCell.")
        }
        
        if self.asset == nil {
            ()
        } else {
            let key = self.asset!.Assets[indexPath.row]
            cell.updateImage.image = UIImage(systemName: "archivebox")
            cell.updateName.text = "\(key.SupportedDevices.joined(separator: ""))_\(key.OSVersion)_\(key.Build)"
            cell.documentationID.text = key.SUDocumentationID
        }
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // https://stackoverflow.com/questions/28788416/swift-prepareforsegue-with-navigation-controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        switch segue.identifier ?? "" {
        case "ShowManageCatalog":
            guard let destinationNavigationController = segue.destination as? UINavigationController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            let targetController = destinationNavigationController.topViewController as! ManageCatalogTableViewController
            targetController.selected_catalog = self.selected_catalog
        case "ShowUpdateDetail":
            guard let destinationNavigationController = segue.destination as? UpdateDetailTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedUpdate = sender as? MainTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            guard let indexPath = tableView.indexPath(for: selectedUpdate) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            destinationNavigationController.asset = self.asset
            destinationNavigationController.index = indexPath.row
        case "ShowSettings":
            ()
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    //MARK: Private Methods
    private func update() throws {
        if self.asset != nil {
            self.asset = nil
            tableView.deleteRows(at: all_indexPath, with: .fade)
            self.all_indexPath = []
        }
        
        let url = URL(string: self.catalog!.assets_url)!
        let data: Data = try Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        self.asset = try decoder.decode(Asset.self, from: data)
        
        for tmp in 0..<self.asset!.Assets.count {
            let newIndexPath = IndexPath(row: tmp, section: 0)
            all_indexPath.append(newIndexPath)
        }
        
        tableView.insertRows(at: all_indexPath, with: .fade)
    }
    
    private func makeSettingsBtn() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.widthAnchor.constraint(equalToConstant: 25).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        button.addTarget(self, action: #selector(self.settingsBtnClick(_:)), for: .touchUpInside)
        
        self.settingsButton.customView = button
        
        /*
         let barButton = UIBarButtonItem(customView: button)
         self.navigationItem.leftBarButtonItem = barButton
         */
    }
    
    @objc private func settingsBtnClick(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ShowSettings", sender: self)
    }
}
