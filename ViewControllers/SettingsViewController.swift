
//
//  SettingsViewController.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/22/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var meatSwitch : UISwitch!
    @IBOutlet weak var meatLabel : UILabel!
    @IBOutlet weak var recipeLabel : UILabel!
    //var meat : Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        println("in settings viewdidload")
         //Do any additional setup after loading the view.
        //if let tmpMeat = IngredientHelper.showMeat{
            if IngredientHelper.showMeat == true{
                meatSwitch.setOn(true, animated:false)
            }
            else{
                meatSwitch.setOn(false, animated:false)
            }
        //}
//        else{
//            IngredientHelper.showMeat = true
//        }
        if meatSwitch.on{
            meatLabel.text = "Display meat - on"
        }
        else{
            meatLabel.text = "Display meat - off"
        }
    }
    @IBAction func buttonClicked(sender: UISwitch) {
        if meatSwitch.on{
            meatLabel.text = "Display meat - on"
            IngredientHelper.showMeat = true
        }
        else{
            meatLabel.text = "Display meat - off"
            IngredientHelper.showMeat = false
        }
    }
    override func viewWillDisappear(animated: Bool) {
       // prepareForSegue(<#segue: UIStoryboardSegue#>, sender: AnyObject?)
        let homeVc = HomeViewController()
        //addNewVcToHierarchy(homeVc)
        //homeVc.displayMeat = meat
        println("displayMeat: \(homeVc.displayMeat)")
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let homeVc = HomeViewController()
//        //addNewVcToHierarchy(homeVc)
//        homeVc.displayMeat = meat
//        println("displayMeat: \(homeVc.displayMeat)")
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
