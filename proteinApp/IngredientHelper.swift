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
        ingredStr = ""
        for i in 0..<ingredients.count{
            if ingredients.count>1 {
                ingredStr = ingredStr! + "\n\n" + ingredients[i].name
                //ingredStr = "\(ingredStr)\n\n\(ingredients[i].name)"
            }
            else{
                ingredStr = ingredients[i].name
            }
        }
    }
    static func returnProteinTotal()->Double{
        var total : Double = 0
        for i in 0..<ingredients.count{
            total = total + ingredients[i].protGram
        }
        return total
    }
    
    static func returnLevelJudgement()->String{
        let protein = returnProteinTotal()
        if(protein > 17){
            return "Excellent!"
        }
        else if(protein > 15){
            return "Great!"
        }
        else if(protein > 10){
            return "Good,"
        }
        else if(protein > 5){
            return "Getting there,"
        }
        else{
            return "Needs more protein,"
        }
    }
}
