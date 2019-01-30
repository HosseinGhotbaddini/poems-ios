//
//  Poem.swift
//  Poems
//
//  Created by Hossein Qotboddini on 1/29/19.
//  Copyright © 2019 Hossein Qotboddini. All rights reserved.
//

import UIKit
import SQLite

class Poem {
    //MARK: The table and it's columns
    static let poemsTable = Table("poems")
    static let idColumn = Expression<Int>("id")
    static let categoryIdColumn = Expression<Int>("categoryId")
    static let titleColumn = Expression<String>("title")
    
    //MARK: Properties
    var id: Int
    var categoryId: Int
    var title: String
    
    
    init(id: Int, categoryId: Int, title: String) {
        self.id = id
        self.categoryId = categoryId
        self.title = title
    }
}
