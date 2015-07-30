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
            tryp = tryp + ingredients[i].tryp
            thre = thre + ingredients[i].thre
            isol = isol + ingredients[i].isol
            leuc = leuc + ingredients[i].leuc
            lysi = lysi + ingredients[i].lysi
            meth = meth + ingredients[i].meth
            phen = phen + ingredients[i].phen
            vali = vali + ingredients[i].vali
            hist = hist + ingredients[i].hist
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
    static func returnAminoJudgement(tryp:Double,thre:Double,isol:Double,leuc:Double,lysi:Double,meth:Double,phen:Double,vali:Double,hist:Double)->(String,UIColor){
        if(tryp/leuc>0.15 ){//&& tryp/leuc<0.35){
            if(thre/leuc>0.4 ){//&& thre/leuc<0.6){
                if(isol/leuc>0.61 ){//&& isol/leuc<0.81){
                    if(lysi/leuc>0.76 ){//&& lysi/leuc<0.96){
                        if(meth/leuc>0.83 ){//&& meth/leuc<1.03){
                            if(phen/leuc>0.9 ){//&& phen/leuc<1.1){
                                return("Excellent balance!",UIColor.greenColor())
                            }
                            else if(phen/leuc<=0.9){
                                return("Good balance,\n needs more Phenylalanine.",UIColor.yellowColor())
                            }
                        }
                        else if(meth/leuc<=0.83){
                            return("Good balance,\n needs more Methionine.",UIColor.yellowColor())
                        }
                    }
                    else if(lysi/leuc<=0.76){
                        return("Good balance,\n needs more Lysine.",UIColor.yellowColor())
                    }
                }
                else if(isol/leuc<=0.61){
                    return("Good balance,\n needs more Isoleucine.",UIColor.yellowColor())
                }
            }
            else if(thre/leuc<=0.4){
                return("Good balance,\n needs more Threonine.",UIColor.yellowColor())
            }
        }
        else if(tryp/leuc<=0.15){
            return("Good balance,\n needs more Tryptophan.",UIColor.yellowColor())
        }
        return("So-so balance",UIColor.redColor())
    }
}
