//
//  ChoosePoemTableViewController.swift
//  Poems
//
//  Created by Hossein Qotboddini on 1/29/19.
//  Copyright © 2019 Hossein Qotboddini. All rights reserved.
//

import UIKit
import SQLite
import os.log

class ChoosePoemTableViewController: UITableViewController {
    //MARK: Properties
    var categories = [Category]()
    var poems = [Poem]()
    var isGonnaShowCategories = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if isGonnaShowCategories {
            return categories.count
        }
        else {
            return poems.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChoosePoemTableViewCell", for: indexPath) as? ChoosePoemTableViewCell else {
            fatalError("The dequeued cell is not an instance of ChoosePoemTableViewCell.")
        }

        if isGonnaShowCategories {
            // Fetches the appropriate category for the data source layout.
            let category = categories[indexPath.row]
            
            cell.nameLabel.text = category.name
            cell.goToNextViewButton.accessibilityIdentifier = String(indexPath.row)
        }
        else {
            // Fetches the appropriate poem for the data source layout.
            let poem = poems[indexPath.row]
            
            cell.nameLabel.text = poem.title
            cell.goToNextViewButton.isHidden = true
            cell.poem = poem
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
        
        if isGonnaShowCategories {
            // Configure the destination view controller only when the goToNextView button is pressed.
            guard let button = sender as? UIButton, let destination = segue.destination as? ChoosePoemTableViewController else {
                os_log("The goToNextView button was not pressed", log: OSLog.default, type: .debug)
                return
            }
            
            let chosenCategory = categories[Int(button.accessibilityIdentifier!)!]
            
            // Load the data.
            let newCategories = loadCategories(chosenCategory.id)
            
            // Check if it's time to switch to poems.
            if newCategories.count > 0 {
                // Set the categories to be passed to ChoosePoemTableViewController.
                destination.categories = newCategories
            }
            else {
                // Load the data.
                let newPoems = loadPoems(chosenCategory.id)
                
                // Set the poems to be passed to ChoosePoemTableViewController.
                destination.poems = newPoems
                
                destination.isGonnaShowCategories = false
            }
            
            destination.navigationItem.title = chosenCategory.name
            destination.navigationItem.leftBarButtonItem?.title = self.navigationItem.title! + " >"
            
        }
        else {
            
            // Configure the destination view controller only when a cell is pressed.
            guard let cell = sender as? ChoosePoemTableViewCell, let destination = segue.destination as? PoemTableViewController else {
                os_log("A cell was not pressed", log: OSLog.default, type: .debug)
                return
            }
            
            // Load the data
            let newVerses = loadVerses(cell.poem.id)
            
            // Set the verses to be passed to PoemTableViewController.
            destination.verses = newVerses
            
            destination.navigationItem.title = cell.poem.title
        }
    }
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Actions
    @IBAction func backToPrevView(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: Private Methodes
    private func loadCategories(_ parentCategoryId: Int) -> [Category] {
        var categories = [Category]()
        do {
            let categoriesTable = try Database.database.prepare(Category.categoriesTable.filter(Category.parentIdColumn == parentCategoryId))
            for category in categoriesTable {
                let newCategory = Category(id: category[Category.idColumn], poetId: category[Category.poetIdColumn], name: category[Category.nameColumn], parentId: category[Category.parentIdColumn], hierarchyLevel: category[Category.hierarchyLevelColumn])
                categories.append(newCategory)
            }
        }
        catch {
            print(error)
        }
        
        return categories
    }
    
    private func loadPoems(_ categoryId: Int) -> [Poem] {
        var poems = [Poem]()
        do {
            let poemsTable = try Database.database.prepare(Poem.poemsTable.filter(Poem.categoryIdColumn == categoryId))
            for poem in poemsTable {
                let newPoem = Poem(id: poem[Poem.idColumn], categoryId: poem[Poem.categoryIdColumn], title: poem[Poem.titleColumn])
                poems.append(newPoem)
            }
        }
        catch {
            print(error)
        }
        
        return poems
    }
 
    private func loadVerses(_ poemId: Int) -> [Verse] {
        var verses = [Verse]()
        do {
            let versesTable = try Database.database.prepare(Verse.versesTable.filter(Verse.poemIdColumn == poemId).order(Verse.orderColumn))
            for verse in versesTable {
                let newVerse = Verse(id: verse[Verse.idColumn], poemId: verse[Verse.poemIdColumn], order: verse[Verse.orderColumn], position: verse[Verse.positionColumn], text: verse[Verse.textColumn])
                verses.append(newVerse)
            }
        }
        catch {
            print(error)
        }
        
        return verses
    }
    
}
