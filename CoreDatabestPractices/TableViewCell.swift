//
//  TableViewCell.swift
//  CoreDatabestPractices
//
//  Created by Prashant Shrestha on 6/19/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
