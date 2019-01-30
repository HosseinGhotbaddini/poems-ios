//
//  Database.swift
//  Poems
//
//  Created by Hossein Qotboddini on 1/28/19.
//  Copyright © 2019 Hossein Qotboddini. All rights reserved.
//

import UIKit
import SQLite

class Database {
    //MARK: Properties
    static var database: Connection!
    static let documentDirectory = Bundle.main.resourceURL!
    static let dbUrl = documentDirectory.appendingPathComponent("database").appendingPathExtension("sqlite")
    
    static func connect() {
        do {
            let database = try Connection(dbUrl.path)
            self.database = database
        }
        catch {
            print(error)
        }
    }
    
}
