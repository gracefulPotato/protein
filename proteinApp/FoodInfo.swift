//
//  FoodInfo.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/13/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit
import Foundation
import Realm
import RealmSwift

class FoodInfo: RLMObject {
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
    
//   override convenience required init(){
//        self.init()
//    }
//    init(name:String,group:String,factor:Double,nitFactor:Double,protGram:Double,tryp:Double,thre:Double,isol:Double,leuc:Double,lysi:Double,meth:Double,phen:Double,vali:Double,hist:Double){
//        self.name = name
//        self.group = group
//        self.factor = factor
//        self.nitFactor = nitFactor
//        self.protGram = protGram
//        self.tryp = tryp
//        self.thre = thre
//        self.isol = isol
//        self.leuc = leuc
//        self.lysi = lysi
//        self.meth = meth
//        self.phen = phen
//        self.vali = vali
//        self.hist = hist
//        super.init()
//        //super.init(name,group,factor,nitFactor,protGram,tryp,thre,isol,leuc,lysi,meth,phen,vali,hist)
//    }
}
