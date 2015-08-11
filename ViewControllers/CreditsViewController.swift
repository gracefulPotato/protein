
//
//  SettingsViewController.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/22/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {
    
    @IBOutlet weak var creditLabel : UILabel!
    //@IBOutlet weak var meatSwitch : UISwitch!
    @IBOutlet weak var meatLabel : UILabel!
    @IBOutlet weak var recipeLabel : UILabel!
    var meat : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("in settings viewdidload")
        if let creditLabel = creditLabel{
            creditLabel.text = "Credits:\n\nApp by Grace O'Hair-Sherman.\n\nApp icon by Ben Smithers.\n\nCooking pot image by Ignat Remizov.\n\nIn-App Icons:\nIcon made by http://www.freepik.com from http://www.flaticon.com\nFlaticon is licensed under http://creativecommons.org/licenses/by/3.0/ Creative Commons BY 3.0\n\nPistachio by Moxilla from the Noun Project\n\nThis product includes software developed by the OpenSSL Project for use in the OpenSSL Toolkit (http://www.openssl.org/)\n\nCopyright 2015 Grace O'Hair-Sherman\n\nLicensed under the Apache License, Version 2.0 (the \"License\");\nyou may not use this file except in compliance with the License.\nYou may obtain a copy of the License at\n\nhttp://www.apache.org/licenses/LICENSE-2.0\n\nUnless required by applicable law or agreed to in writing, software\ndistributed under the License is distributed on an \"AS IS\" BASIS,\nWITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.\nSee the License for the specific language governing permissions and\nlimitations under the License."
        }
        // Do any additional setup after loading the view.
        //        if let tmpMeat = meat{
        //            if meat == true{
        //                meatSwitch.setOn(true, animated:false)
        //            }
        //            else{
        //                meatSwitch.setOn(false, animated:false)
        //            }
        //        }
        //        else{
        //            meat = true
        //        }
        //        if meatSwitch.on{
        //            meatLabel.text = "Display meat - on"
        //        }
        //        else{
        //            meatLabel.text = "Display meat - off"
        //        }
        //    }
        //    @IBAction func buttonClicked(sender: UISwitch) {
        //        if meatSwitch.on{
        //            meatLabel.text = "Display meat - on"
        //            meat = true
        //        }
        //        else{
        //            meatLabel.text = "Display meat - off"
        //            meat = false
        //        }
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
