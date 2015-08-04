//
//  RecipeTableViewCell.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/31/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeTextView : UITextView!
    @IBOutlet weak var userMadePic : UIImageView!
    @IBOutlet weak var titletextView : UITextField!
    var correspondRecipe : RecipeWithPicture!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //recipeTextView.scrollEnabled = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
