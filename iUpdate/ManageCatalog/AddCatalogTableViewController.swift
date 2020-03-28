//
//  AddCatalogTableViewController.swift
//  iUpdate
//
//  Created by pook on 3/29/20.
//  Copyright © 2020 pook. All rights reserved.
//

import UIKit

class AddCatalogTableViewController: UITableViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var cells = [AddCatalogTableViewCell]()
    var catalog = Catalog(name: "", assets_url: "", documentation_url: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.updateSaveButtonState()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCatalogTableViewCell", for: indexPath) as! AddCatalogTableViewCell
        
        // Configure the cell...
        switch indexPath.row {
        case 0:
            cell.name.text = "Catalog name"
            cell.value.delegate = self
        case 1:
            cell.name.text = "Asset URL"
            cell.value.delegate = self
        case 2:
            cell.name.text = "Documentation URL"
            cell.value.delegate = self
        default:
            ()
        }
        
        self.cells.append(cell)
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    //MARK: UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.cells[0].value:
            self.catalog.name = textField.text!
        case self.cells[1].value:
            self.catalog.assets_url = textField.text!
        case self.cells[2].value:
            self.catalog.documentation_url = textField.text!
        default:
            ()
        }
        updateSaveButtonState()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.saveButton.isEnabled = false
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        var status = true
        let _ = self.cells.map {
            if $0.value.text == "" {
                status = false
            }
        }
        self.saveButton.isEnabled = status
    }
}
