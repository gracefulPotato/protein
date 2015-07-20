//
//  FoodTableViewCell.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/15/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!

    var foodnote: FoodInfo! {
        didSet {
            self.nameLabel.text = foodnote.name
        }
    }
}
