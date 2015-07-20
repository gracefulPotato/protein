//
//  DisplayViewController.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/16/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit
import JBChartView

class DisplayViewController: UIViewController, JBBarChartViewDataSource, JBBarChartViewDelegate {
    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleTextField: UILabel!
    @IBOutlet weak var groupTextView: UILabel!
    @IBOutlet weak var protGramTextView: UILabel!
    @IBAction func backButton(sender: AnyObject) {
    }

    @IBOutlet weak var barChartView : JBBarChartView!//{
        //didSet{
            //barChartView.dataSource = self //as JBChartViewDataSource
            //barChartView.delegate = self //as JBChartViewDelegate!
            //self.addSubView = barChartView
        //}
    //}

    
    var note: FoodInfo? {
        didSet {
            println("in note didset")
            displayFood(self.note)
            println(self.note!.name)
            println("after calling displayFood")
            
        }
    }
    
    func displayFood(note: FoodInfo?) {
        println("in displayFood")
        if let note = note{
            println("in conditional")
            if let titleTextField = titleTextField, groupTextView = groupTextView, protGramTextView = protGramTextView  {
                println("in inner conditional")
                titleTextField.text = note.name
                println(titleTextField)
                groupTextView.text = "Food Group:\n\(note.group)"
                protGramTextView.text = "Total protein: \(note.protGram) grams"
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //titleTextField.numberOfLines = 0
        barChartView.dataSource = self
        barChartView.delegate = self
        println(barChartView.dataSource)
        barChartView.minimumValue = 0
        barChartView.maximumValue = 10
        titleTextField.adjustsFontSizeToFitWidth = true
        println("View DId Load")
        //barChartView.frame = CGRectMake(100,100,200,200)
        barChartView.reloadData()
        displayFood(self.note)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // our code
        barChartView.reloadData()
        
//        var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("showChart"), userInfo: nil, repeats: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FoodCell", forIndexPath: indexPath) as! FoodTableViewCell //1
        
        let row = indexPath.row

        cell.nameLabel?.text = ""
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return Int(allFoods.count)
            return 1
    }
    //func numberOfBarsInBarChartView(barChartView: JBBarChartView)->NSInteger{
    //    return 9 // number of bars in chart
    //}
//    func numberOfBarsInBarChartView(barChartView: JBBarChartView!) -> UInt {
//        return 9
//    }
    
    func numberOfBarsInBarChartView(barChartView: JBBarChartView!) -> UInt {
        return 9
    }
    
    func barChartView(barChartView: JBBarChartView!, heightForBarViewAtIndex index: UInt) -> CGFloat {
        switch index{
        case 1:
            return CGFloat(note!.tryp)
        case 2:
            return CGFloat(note!.thre)
        case 3:
            return CGFloat(note!.isol)
        case 4:
            return CGFloat(note!.leuc)
        case 5:
            return CGFloat(note!.lysi)
        case 6:
            return CGFloat(note!.meth)
        case 7:
            return CGFloat(note!.phen)
        case 8:
            return CGFloat(note!.vali)
        case 9:
            return CGFloat(note!.hist)
        default:
            return 0
        }
        //return 1
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
