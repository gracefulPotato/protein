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
    static var multipliers: [Int]! = []
    static var ingredStr : String?
//    static func viewDidLoad(){
//        //super.viewDidLoad()
//        createString()
//    }
    static var tmpRecipeStr : String?
    static var sortCat : String! = "name"
    static var ascendDescend : Bool = true
    static var tmpCategory : String = ""
    static var displayMessage : Bool = false
    //static var showMeat : Bool = true
    dynamic var showMeat : Bool = true
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
            total = total + ((ingredients[i].protGram/100) * Double(multipliers[i]))
        }
        return total
    }
    
    static func returnAminoTotals()->(Double,Double,Double,Double,Double,Double,Double,Double,Double){
        var tryp : Double = 0
        var thre : Double = 0
        var isol : Double = 0
        var leuc : Double = 0
        var lysi : Double = 0
        var meth : Double = 0
        var phen : Double = 0
        var vali : Double = 0
        var hist : Double = 0
        for i in 0..<ingredients.count{
            tryp = tryp + ((ingredients[i].tryp/100) * Double(multipliers[i]))
            thre = thre + ((ingredients[i].thre/100) * Double(multipliers[i]))
            isol = isol + ((ingredients[i].isol/100) * Double(multipliers[i]))
            leuc = leuc + ((ingredients[i].leuc/100) * Double(multipliers[i]))
            lysi = lysi + ((ingredients[i].lysi/100) * Double(multipliers[i]))
            meth = meth + ((ingredients[i].meth/100) * Double(multipliers[i]))
            phen = phen + ((ingredients[i].phen/100) * Double(multipliers[i]))
            vali = vali + ((ingredients[i].vali/100) * Double(multipliers[i]))
            hist = hist + ((ingredients[i].hist/100) * Double(multipliers[i]))
        }
        return (tryp,thre,isol,leuc,lysi,meth,phen,vali,hist)
    }
    
    static func returnLevelJudgement()->(String,UIColor){
        let protein = returnProteinTotal()
        if(protein > 17){
            return ("Excellent!",UIColor.greenColor())
        }
        else if(protein > 15){
            return ("Great!",UIColor.greenColor())
        }
        else if(protein > 10){
            return ("Good.",UIColor.orangeColor())
        }
        else if(protein > 5){
            return ("Getting there.",UIColor.orangeColor())
        }
        else{
            return ("Needs more protein.",UIColor.redColor())
        }
    }
    static func returnAminoJudgement(tryp:Double,thre:Double,isol:Double,leuc:Double,lysi:Double,meth:Double,phen:Double,vali:Double,hist:Double)->(Bool,String,UIColor){
        if(tryp/leuc>0.15 ){//&& tryp/leuc<0.35){
            if(thre/leuc>0.4 ){//&& thre/leuc<0.6){
                if(isol/leuc>0.61 ){//&& isol/leuc<0.81){
                    if(lysi/leuc>0.76 ){//&& lysi/leuc<0.96){
                        if(meth/leuc>0.83 ){//&& meth/leuc<1.03){
                            if(phen/leuc>0.9 ){//&& phen/leuc<1.1){
                                return(true,"Excellent balance!",UIColor.greenColor())
                            }
                            else if(phen/leuc<=0.9){
                                return(false,"Phenylalanine",UIColor.yellowColor())
                            }
                        }
                        else if(meth/leuc<=0.83){
                            return(false,"Methionine",UIColor.yellowColor())
                        }
                    }
                    else if(lysi/leuc<=0.76){
                        return(false,"Lysine",UIColor.yellowColor())
                    }
                }
                else if(isol/leuc<=0.61){
                    return(false,"Isoleucine",UIColor.yellowColor())
                }
            }
            else if(thre/leuc<=0.4){
                return(false,"Threonine",UIColor.yellowColor())
            }
        }
        else if(tryp/leuc<=0.15){
            return(false,"Tryptophan",UIColor.yellowColor())
        }
        return(false,"So-so balance",UIColor.redColor())
    }
    static func mapAminoNames(name:String)->String{
        switch(name){
            case "Tryptophan":
            return "tryp"
            case "Threonine":
            return "thre"
            case "Isoleucine":
            return "isol"
            case "Leucine":
            return "leuc"
            case "Lysine":
            return "lysi"
            case "Methionine":
            return "meth"
            case "Phenylalanine":
            return "phen"
            case "Valine":
            return "vali"
            case "Histidine":
            return "hist"
        default:
            return "name"
        }
    }
    static func mapAminoVars(name:String)->String{
        switch(name){
        case "tryp":
            return "Tryptophan"
        case "thre":
            return "Threonine"
        case "isol":
            return "Isoleucine"
        case "leuc":
            return "Leucine"
        case "lysi":
            return "Lysine"
        case "meth":
            return "Methionine"
        case "phen":
            return "Phenylalanine"
        case "vali":
            return "Valine"
        case "hist":
            return "Histidine"
        default:
            return "name"
        }
    }
    static func mapImgsToCats(imgName:String)->String{
        switch(imgName){
        case "fish_32.png":
            return "Fish"
        case "Salami_32.png":
            return "Sausages, etc."
        case "Wheat_32.png":
            return "Grains and Pasta"
        case "Broccoli_32.png":
            return "Vegetables"
        case "beverage_32.png":
            return "Beverages"
        case "pistachio.png":
            return "Nuts and Seeds"
        case "Peas_32.png":
            return "Legumes"
        case "Chicken_32.png":
            return "Poultry"
        case "Piece_of_cheese_32.png":
            return "Dairy and Egg"
        case "Grapes_32.png":
            return "Fruit"
        default:
            return "name"
        }
    }

}
