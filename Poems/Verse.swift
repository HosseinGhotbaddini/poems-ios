//
//  Verse.swift
//  Poems
//
//  Created by Hossein Qotboddini on 1/30/19.
//  Copyright © 2019 Hossein Qotboddini. All rights reserved.
//

import UIKit
import SQLite

class Verse {
    //MARK: The table and it's columns
    static let versesTable = Table("verses")
    static let idColumn = Expression<Int>("id")
    static let poemIdColumn = Expression<Int>("poemId")
    static let orderColumn = Expression<Int>("order")
    static let positionColumn = Expression<Int>("position")
    static let textColumn = Expression<String>("text")
    
    
    //MARK: Properties
    var id: Int
    var poemId: Int
    var order: Int
    var position: Int
    var text: String
    
    
    init(id: Int, poemId: Int, order: Int, position: Int, text: String) {
        self.id = id
        self.poemId = poemId
        self.order = order
        self.position = position
        self.text = text
    }
}
