
//
//  SettingsViewController.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/22/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var creditLabel : UILabel!
    @IBOutlet weak var meatSwitch : UISwitch!
    @IBOutlet weak var meatLabel : UILabel!
    @IBOutlet weak var recipeLabel : UILabel!
    var meat : Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        println("in settings viewdidload")
        if let creditLabel = creditLabel{
            creditLabel.text = "Credits:\n\nApp icon by Ben Smithers.\n\nCooking pot image by Ignat Remizov.\n\nIn-App Icons:\nIcon made by http://www.freepik.com from http://www.flaticon.com\nFlaticon is licensed under http://creativecommons.org/licenses/by/3.0/ Creative Commons BY 3.0\n\nPistachio by Moxilla from the Noun Project"
        }
//        if let recipeLabel = recipeLabel{
//            println("in conditional")
//            for i in 0..<realm.objects(RecipeWithPicture).count{
//                recipeLabel.text = RecipeWithPicture(value: realm.objects(RecipeWithPicture)[i]).ingredientStr
//                println("recipeLabel.text\(recipeLabel.text)")
//            }
//            println("realm.objects(RecipeWithPicture).count: \(realm.objects(RecipeWithPicture).count)")
//            println(realm.objects(RecipeWithPicture))
//        }
        // Do any additional setup after loading the view.
        if let tmpMeat = meat{
            if meat == true{
                meatSwitch.setOn(true, animated:false)
            }
            else{
                meatSwitch.setOn(false, animated:false)
            }
        }
        else{
            meat = true
        }
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
            meat = true
        }
        else{
            meatLabel.text = "Display meat - off"
            meat = false
        }
    }
    override func viewWillDisappear(animated: Bool) {
       // prepareForSegue(<#segue: UIStoryboardSegue#>, sender: AnyObject?)
        let homeVc = HomeViewController()
        //addNewVcToHierarchy(homeVc)
        homeVc.displayMeat = meat
        println("displayMeat: \(homeVc.displayMeat)")
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let homeVc = HomeViewController()
//        //addNewVcToHierarchy(homeVc)
//        homeVc.displayMeat = meat
//        println("displayMeat: \(homeVc.displayMeat)")
//    }
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}