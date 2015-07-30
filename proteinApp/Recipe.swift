//
//  Recipe.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/29/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit
import Foundation
import Realm
import RealmSwift

class RecipeObj: RLMObject{
    
    //dynamic var ingredientList : RLMArray<FoodInfo>
    dynamic var ingredientStr : String = ""
    dynamic var title : String = ""
    dynamic var totProt : Double = 0
}
