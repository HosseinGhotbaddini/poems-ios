//
//  PoetTableViewController.swift
//  Poems
//
//  Created by Hossein Qotboddini on 1/28/19.
//  Copyright © 2019 Hossein Qotboddini. All rights reserved.
//

import UIKit
import SQLite
import os.log

class PoetTableViewController: UITableViewController {
    //MARK: Properties
    var poets = [Poet]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect to the database.
        Database.connect()
        
        // Load the data.
        loadPoets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PoetsTableViewCell", for: indexPath) as? PoetTableViewCell else {
            fatalError("The dequeued cell is not an instance of PoetTableViewCell.")
        }

        // Fetches the appropriate poet for the data source layout.
        let poet = poets[indexPath.row]
        
        cell.nameLabel.text = poet.name
        cell.poet = poet

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when a poet cell is pressed.
        guard let courcePoetCell = sender as? PoetTableViewCell, let destination = segue.destination as? ViewController else {
            os_log("A poet cell was not pressed", log: OSLog.default, type: .debug)
            return
        }
        
        let poet = courcePoetCell.poet
        
        // Set the poet to be passed to ViewController.
        destination.poet = poet
    }
    
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Private Methodes
    private func loadPoets() {
        do {
            let poets = try Database.database.prepare(Poet.poetsTable)
            for poet in poets {
                let newPoet = Poet(id: poet[Poet.idColumn], name: poet[Poet.nameColumn], categoryId: poet[Poet.categoryIdColumn], desc: poet[Poet.descriptionColumn])
                self.poets.append(newPoet)
            }
        }
        catch {
            print(error)
        }
    }

}
