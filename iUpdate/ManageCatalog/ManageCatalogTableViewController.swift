//
//  ManageCatalogTableViewController.swift
//  iUpdate
//
//  Created by pook on 3/23/20.
//  Copyright © 2020 pook. All rights reserved.
//

import UIKit

class ManageCatalogTableViewController: UITableViewController {
    
    @IBAction func unwindToCatalogList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddCatalogTableViewController {
            let newIndexPath = IndexPath(row: catalogs.count, section: 0)
            self.catalogs.append(sourceViewController.catalog)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    //MARK: Properties
    
    var catalogs = [Catalog]()
    var cells = [ManageCatalogTableViewCell]()
    var selected_catalog: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        self.loadDefaultCatalogs()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return catalogs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageCatalogTableViewCell", for: indexPath) as! ManageCatalogTableViewCell
        
        // Configure the cell...
        let catalog = catalogs[indexPath.row]
        cell.catalogLabel.text = catalog.name
        if selected_catalog == indexPath.row {
            cell.catalogImage.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            cell.catalogImage.image = UIImage(systemName: "circle")
        }
        
        cells += [cell]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected_catalog = indexPath.row
        for n in 0..<cells.count {
            if selected_catalog == n {
                cells[n].catalogImage.image = UIImage(systemName: "checkmark.circle.fill")
            } else {
                cells[n].catalogImage.image = UIImage(systemName: "circle")
            }
        }
        //cells[indexPath.row].isSelected = false
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    //MARK: Private Methods
    private func loadDefaultCatalogs() {
        //let ios12 = Catalog(name: "iOS12DeveloperSeed", assets_url: "https://mesu.apple.com/assets/iOS12DeveloperSeed/com_apple_MobileAsset_SoftwareUpdate/com_apple_MobileAsset_SoftwareUpdate.xml", documentation_url: "https://mesu.apple.com/assets/iOS12DeveloperSeed/com_apple_MobileAsset_SoftwareUpdateDocumentation/com_apple_MobileAsset_SoftwareUpdateDocumentation.xml")
        let ios13_dev = Catalog(name: "iOS13DeveloperSeed", assets_url: "https://mesu.apple.com/assets/iOS13DeveloperSeed/com_apple_MobileAsset_SoftwareUpdate/com_apple_MobileAsset_SoftwareUpdate.xml", documentation_url: "https://mesu.apple.com/assets/iOS13DeveloperSeed/com_apple_MobileAsset_SoftwareUpdateDocumentation/com_apple_MobileAsset_SoftwareUpdateDocumentation.xml")
        let ios13_pub = Catalog(name: "iOS13PublicSeed", assets_url: "https://mesu.apple.com/assets/iOS13PublicSeed/com_apple_MobileAsset_SoftwareUpdate/com_apple_MobileAsset_SoftwareUpdate.xml", documentation_url: "https://mesu.apple.com/assets/iOS13PublicSeed/com_apple_MobileAsset_SoftwareUpdateDocumentation/com_apple_MobileAsset_SoftwareUpdateDocumentation.xml")
        catalogs += [ios13_dev, ios13_pub]
    }
}
