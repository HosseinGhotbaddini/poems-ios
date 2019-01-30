//
//  ChoosePoemTableViewCell.swift
//  Poems
//
//  Created by Hossein Qotboddini on 1/29/19.
//  Copyright © 2019 Hossein Qotboddini. All rights reserved.
//

import UIKit

class ChoosePoemTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var goToNextViewButton: UIButton!
    var poem: Poem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
