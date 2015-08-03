//
//  FoodInfo.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/13/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class FoodInfo: Object {
    dynamic var name : String = ""
    dynamic var group : String = ""
    dynamic var factor : Double = 0
    dynamic var nitFactor : Double = 0
    dynamic var protGram : Double = 0
    dynamic var tryp : Double = 0
    dynamic var thre : Double = 0
    dynamic var isol : Double = 0
    dynamic var leuc : Double = 0
    dynamic var lysi : Double = 0
    dynamic var meth : Double = 0
    dynamic var phen : Double = 0
    dynamic var vali : Double = 0
    dynamic var hist : Double = 0
    
    //dynamic var partOfRecipes : RLMArray!
}
