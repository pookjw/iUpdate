//
//  DocumentationListTableViewController.swift
//  iUpdate
//
//  Created by pook on 3/30/20.
//  Copyright © 2020 pook. All rights reserved.
//

import UIKit

class DocumentationListTableViewController: UITableViewController {
    
    //MARK: Properties
    var documentation: Documentation? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.documentation == nil {
            return 0
        }
        return self.documentation!.Assets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "DocumentationListTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? DocumentationListTableViewCell else {
            fatalError("The dequeued cell is not an instance of DocumentationListTableViewCell.")
        }
        
        cell.documentationImage.image = UIImage(systemName: "doc.text")
        cell.documentationID.text = self.documentation!.Assets[indexPath.row].SUDocumentationID
        cell.device.text = self.documentation!.Assets[indexPath.row].Device

        // Configure the cell...

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        switch segue.identifier ?? "" {
        case "ShowDocumentationDetail":
           guard let destinationNavigationController = segue.destination as? DocumentationDetailTableViewController else {
               fatalError("Unexpected destination: \(segue.destination)")
           }
           guard let selectedUpdate = sender as? DocumentationListTableViewCell else {
               fatalError("Unexpected sender: \(sender)")
           }
           guard let indexPath = tableView.indexPath(for: selectedUpdate) else {
               fatalError("The selected cell is not being displayed by the table")
           }
           destinationNavigationController.documentation = self.documentation
           destinationNavigationController.index = indexPath.row
        default:
            ()
            //fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
        
    }

}
