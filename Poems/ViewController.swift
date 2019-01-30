//
//  ViewController.swift
//  Poems
//
//  Created by Hossein Qotboddini on 1/27/19.
//  Copyright © 2019 Hossein Qotboddini. All rights reserved.
//

import UIKit
import SQLite
import os.log

class ViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var descriptionLabel: UILabel!
    var poet: Poet!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = poet.name
        
        if (!poet.desc.isEmpty) {
            descriptionLabel.text = poet.desc
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    @IBAction func backToPoetTable(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the aasaar button is pressed.
        guard let _ = sender as? UIBarButtonItem, let destination = segue.destination as? ChoosePoemTableViewController else {
            os_log("The aasaar button was not pressed", log: OSLog.default, type: .debug)
            return
        }
        
        // Load the data.
        let newCategories = loadCategories(poet.categoryId)
        
        // Check if we should switch to poems.
        if newCategories.count > 0 {
            // Set the categories to be passed to ChoosePoemTableViewController.
            destination.categories = newCategories
        }
        else {
            // Load the data.
            let newPoems = loadPoems(poet.categoryId)
            
            // Set the poems to be passed to ChoosePoemTableViewController.
            destination.poems = newPoems
            
            destination.isGonnaShowCategories = false
        }
        
        destination.navigationItem.title = "آثار"
        destination.navigationItem.leftBarButtonItem?.title = poet.name + " >"
        
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

}

