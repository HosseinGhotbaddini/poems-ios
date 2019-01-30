//
//  Category.swift
//  Poems
//
//  Created by Hossein Qotboddini on 1/29/19.
//  Copyright © 2019 Hossein Qotboddini. All rights reserved.
//

import UIKit
import SQLite

class Category {
    //MARK: The table and it's columns
    static let categoriesTable = Table("categories")
    static let idColumn = Expression<Int>("id")
    static let poetIdColumn = Expression<Int>("poetId")
    static let nameColumn = Expression<String>("name")
    static let parentIdColumn = Expression<Int?>("parentId")
    static let hierarchyLevelColumn = Expression<Int>("hierarchyLevel")
    
    //MARK: Properties
    var id: Int
    var poetId: Int
    var name: String
    var parentId: Int?
    var hierarchyLevel: Int
    
    init(id: Int, poetId: Int, name: String, parentId: Int?, hierarchyLevel: Int) {
        self.id = id
        self.poetId = poetId
        self.name = name
        self.parentId = parentId
        self.hierarchyLevel = hierarchyLevel
    }
    
}
