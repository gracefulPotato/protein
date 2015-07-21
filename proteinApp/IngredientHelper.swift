//
//  IngredientHelper.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/21/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit

class IngredientHelper: NSObject {
   static var ingredients: [FoodInfo]! = []
    static var ingredStr : String?
//    static func viewDidLoad(){
//        //super.viewDidLoad()
//        createString()
//    }
    static func createString(){
        for i in 0..<ingredients.count{
            if ingredients.count>1 {
                ingredStr = "\(ingredients[i].name)\n\n\(ingredStr)"
            }
            else{
                ingredStr = "\(ingredients[i].name)"
            }
        }
    }
}
