//
//  Poet.swift
//  Poems
//
//  Created by Hossein Qotboddini on 1/28/19.
//  Copyright © 2019 Hossein Qotboddini. All rights reserved.
//

import UIKit
import SQLite

class Poet {
    //MARK: The table and it's columns
    static let poetsTable = Table("poets")
    static let idColumn = Expression<Int>("id")
    static let nameColumn = Expression<String>("name")
    static let categoryIdColumn = Expression<Int>("categoryId")
    static let descriptionColumn = Expression<String>("description")
    
    //MARK: Properties
    var id: Int
    var name: String
    var categoryId: Int
    var desc: String
    

    init(id: Int, name: String, categoryId: Int, desc: String) {
        self.id = id
        self.name = name
        self.categoryId = categoryId
        self.desc = desc
    }
}
