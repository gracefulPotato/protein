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

    //required init(coder aDecoder: NSCoder) {
    //    fatalError("init(coder:) has not been implemented")
    //}
    var foodnote: FoodInfo! {
        didSet {
            self.nameLabel.text = foodnote.name
        }
    }
    //override init(style style: UITableViewCellStyle, reuseIdentifier reuseIdentifier: String?){
    //    super.init(style: style, reuseIdentifier: reuseIdentifier)
   // }
    //required init(coder aDecoder: NSCoder!)
    //{
    //    self.foodnote = foodnote
    //    //nameLabel.text = JsonHelper.foodsArr[SearchViewController.indexPath.row].name
     //   super.init(coder: aDecoder)
   // }

}
