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

    override func viewDidLoad() {
        super.viewDidLoad()
        if let creditLabel = creditLabel{
            creditLabel.text = "Credits:\n\nCooking pot image by Ignat Remizov\n\nIcons:\nIcon made by http://www.freepik.com from http://www.flaticon.com\nFlaticon is licensed under http://creativecommons.org/licenses/by/3.0/ Creative Commons BY 3.0\n\nPistachio by Moxilla from the Noun Project"
        }
        // Do any additional setup after loading the view.
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
