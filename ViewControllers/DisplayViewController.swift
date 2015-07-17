//
//  DisplayViewController.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/16/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {

    @IBAction func backButton(sender: AnyObject) {
        
    }
    @IBOutlet weak var titleTextField: UILabel!
    @IBOutlet weak var contentTextView: UILabel!

    var note: FoodInfo? {
        didSet {
            println("in note didset")
            titleTextField.text = ""
            contentTextView.text = ""
            displayFood(self.note)
            println(self.note!.name)
            println("after calling displayFood")
        }
    }
    
    func displayFood(note: FoodInfo?) {
        println("in displayFood")
        if let note = note{
            println("in conditional!")
            if let titleTextField = titleTextField, contentTextView = contentTextView  {
                println("in inner conditional!")
                titleTextField.text = note.name
                println(titleTextField)
                let allInfo : String = "\(note.group)\n\(note.factor)\n\(note.protGram)"
                contentTextView.text = allInfo
           }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
