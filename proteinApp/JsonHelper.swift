//
//  JsonHelper.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/15/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit
import SwiftyJSON
import Realm
import RealmSwift

struct JsonHelper {
    static var foodsArr = [FoodInfo]()
    static func loadData() {
        let jsonFilePath:NSString = NSBundle.mainBundle().pathForResource("foodinfo", ofType: "json")!
        let jsonData:NSData = NSData.dataWithContentsOfMappedFile(jsonFilePath as String) as! NSData
        let error:NSError?
        let json = JSON(data: jsonData)
        //println(json)
        println(json["foods"][0]["name"])
        println(json["foods"].count)
        let realm = RLMRealm.defaultRealm()
        for i in 0..<3525{
            println(i)
            let newFood : FoodInfo = FoodInfo()

            newFood.name = json["foods"][i]["name"].stringValue
            newFood.group = json["foods"][i]["group"].stringValue
            if let factor = json["foods"][i]["factor"].double{
                newFood.factor = factor
            }
            if let nitFactor = json["foods"][i]["nitFactor"].double{
                newFood.nitFactor = nitFactor
            }
            newFood.protGram = json["foods"][i]["protGram"].double!
            newFood.tryp = json["foods"][i]["tryp"].double!
            newFood.thre = json["foods"][i]["thre"].double!
            newFood.isol = json["foods"][i]["isol"].double!
            newFood.leuc = json["foods"][i]["leuc"].double!
            newFood.lysi = json["foods"][i]["lysi"].double!
            newFood.meth = json["foods"][i]["meth"].double!
            newFood.phen = json["foods"][i]["phen"].double!
            newFood.vali = json["foods"][i]["vali"].double!
            newFood.hist = json["foods"][i]["hist"].double!
            realm.transactionWithBlock() {
                realm.addObject(newFood)
            }
            //foodsArr.append(newFood)
            //let newFood : FoodInfo = FoodInfo(name:name,group:group,factor:factor!,nitFactor:nitFactor!,protGram:protGram!,tryp:tryp!,thre:thre!,isol:isol!,leuc:leuc!,lysi:lysi!,meth:meth!,phen:phen!,vali:vali!,hist:hist!)
        }
        //json["foods"] as! [NSObject]
        //for food in json["foods"]{
        //    println(food["name"])
            //let newFood : FoodInfo = FoodInfo(name:food."name",group:food."group",factor:food."factor",nitFactor:food."nitFactor",protGram:food."protGram",tryp:food."tryp",thre:food."thre",isol:food."isol",leuc:food."leuc",lysi:food."lysi",meth:food."meth",phen:food."phen",vali:food."vali",hist:food."hist")
        //}
    }
}
