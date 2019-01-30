//
//  PoetTableViewCell.swift
//  Poems
//
//  Created by Hossein Qotboddini on 1/28/19.
//  Copyright © 2019 Hossein Qotboddini. All rights reserved.
//

import UIKit

class PoetTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    var poet: Poet!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
