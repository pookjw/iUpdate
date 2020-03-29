//
//  UpdateDetailTableViewController.swift
//  iUpdate
//
//  Created by pook on 3/28/20.
//  Copyright © 2020 pook. All rights reserved.
//

import UIKit

class UpdateDetailTableViewController: UITableViewController {
    
    @IBAction func unwindToDetail(sender: UIStoryboardSegue) {
        /*if let sourceViewController = sender.source as? ManageCatalogTableViewController {
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
         }*/
    }
    
    //MARK: Properties
    @IBOutlet weak var showUpdateDescriptionBtn: UIBarButtonItem!
    var asset: Asset? = nil
    var documentation: Documentation? = nil
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = self.asset!.Assets[self.index!].SUDocumentationID
        self.setNavBarBtn()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "UpdateDetailTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? UpdateDetailTableViewCell else {
            fatalError("The dequeued cell is not an instance of UpdateDetailTableViewCell.")
        }
        
        let key = self.asset!.Assets[self.index!]
        
        switch indexPath.row {
        case 0:
            cell.name.text = "Build"
            cell.value.text = key.Build
        case 1:
            cell.name.text = "OSVersion"
            cell.value.text = key.OSVersion
        case 2:
            cell.name.text = "PrerequisiteBuild"
            if key.PrerequisiteOSVersion == nil {
                cell.value.text = "(nil)"
            } else {
                cell.value.text = key.PrerequisiteBuild
            }
        case 3:
            cell.name.text = "PrerequisiteOSVersion"
            if key.PrerequisiteOSVersion == nil {
                cell.value.text = "(nil)"
            } else {
                cell.value.text = key.PrerequisiteOSVersion
            }
        case 4:
            cell.name.text = "SUDocumentationID"
            cell.value.text = key.SUDocumentationID
        case 5:
            cell.name.text = "SupportedDeviceModels"
            cell.value.text = key.SupportedDeviceModels.joined(separator: ", ")
        case 6:
            cell.name.text = "SupportedDevices"
            cell.value.text = key.SupportedDevices.joined(separator: ", ")
        case 7:
            cell.name.text = "__BaseURL"
            cell.value.text = key.__BaseURL
        case 8:
            cell.name.text = "__RelativePath"
            cell.value.text = key.__RelativePath
        case 9:
            cell.name.text = "Full URL"
            cell.value.text = "\(key.__BaseURL)\(key.__RelativePath)"
        default:
            ()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pasteboard = UIPasteboard.general
        let key = self.asset!.Assets[self.index!]
        
        switch indexPath.row {
        case 0:
            pasteboard.string = key.Build
        case 1:
            pasteboard.string = key.OSVersion
        case 2:
            if key.PrerequisiteOSVersion != nil {
                pasteboard.string = key.PrerequisiteBuild
            }
        case 3:
            if key.PrerequisiteOSVersion != nil {
                pasteboard.string = key.PrerequisiteOSVersion
            }
        case 4:
            pasteboard.string = key.SUDocumentationID
        case 5:
            pasteboard.string = key.SupportedDeviceModels.joined(separator: ", ")
        case 6:
            pasteboard.string = key.SupportedDevices.joined(separator: ", ")
        case 7:
            pasteboard.string = key.__BaseURL
        case 8:
            pasteboard.string = key.__RelativePath
        case 9:
            pasteboard.string = "\(key.__BaseURL)\(key.__RelativePath)"
        default:
            ()
        }
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        switch segue.identifier ?? "" {
        case "ShowUpdateDescription":
            guard let destinationNavigationController = segue.destination as? UINavigationController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            let targetController = destinationNavigationController.topViewController as! DescriptionViewController
            
            let assets_key = self.asset!.Assets[self.index!]
            targetController.documentation_id = assets_key.SUDocumentationID
            
            let _ = self.documentation!.Assets.map {
                if $0.SUDocumentationID == assets_key.SUDocumentationID {
                    targetController.documentation_url = "\($0.__BaseURL)\($0.__RelativePath)"
                }
            }
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    
    //MARK: Private Methods
    
    private func setNavBarBtn() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.widthAnchor.constraint(equalToConstant: 25).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        button.addTarget(self, action: #selector(self.barBtnClick(_:)), for: .touchUpInside)
        
        self.showUpdateDescriptionBtn.customView = button
        
        /*
         let barButton = UIBarButtonItem(customView: button)
         self.navigationItem.leftBarButtonItem = barButton
         */
    }
    
    @objc private func barBtnClick(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ShowUpdateDescription", sender: self)
    }
    
}
