//
//  FirstViewController.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/10/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var toolbarBottomSpace: NSLayoutConstraint!
    let allFoods : RLMResults = FoodInfo.allObjects()
    var carrySearchText : String?
    var resultsArr = [FoodInfo]()
    var keyboardNotificationHandler: KeyboardNotificationHandler?
    enum State {
        case DefaultMode
        case SearchMode
    }
    var selectedFood: FoodInfo?
    var state: State = .DefaultMode{
        didSet{
        switch (state) {
        case .DefaultMode:
            notes = allFoods.sortedResultsUsingProperty("name", ascending: true)
            //self.navigationController!.setNavigationBarHidden(false, animated: true)
            searchBar.resignFirstResponder()
            searchBar.text = ""
            searchBar.showsCancelButton = false
            println(notes)
        case .SearchMode:
            let searchText = searchBar?.text ?? ""
            //carrySearchText = searchText as String?
            searchBar.setShowsCancelButton(true, animated: true)
            notes = searchNotes(searchText)
            //for i in 0..<notes.count{
//                var tmpIndex = Int(i)
//                resultsArr[tmpIndex] = notes[i] as! FoodInfo
//            }
            //self.navigationController!.setNavigationBarHidden(true, animated: true)
            println(notes)
        }
        }
    }
    var filtered:[FoodInfo] = []
    
    let items : [String] = ["Avocado", "Bread","Cheese"]
    static var foods = [FoodInfo]()
    
    var notes: RLMResults! {
        didSet {
            // Whenever notes update, update the table view
            if let tableView = tableView {
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //notes = allFoods
        notes = allFoods.sortedResultsUsingProperty("name", ascending: true)
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        
    }
    override func viewWillAppear(animated: Bool) {
        keyboardNotificationHandler = KeyboardNotificationHandler()
        
        keyboardNotificationHandler!.keyboardWillBeHiddenHandler = { (height: CGFloat) in
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.toolbarBottomSpace.constant = 0
                self.view.layoutIfNeeded()
            })
        }
        
        keyboardNotificationHandler!.keyboardWillBeShownHandler = { (height: CGFloat) in
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.toolbarBottomSpace.constant = height
                self.view.layoutIfNeeded()
            })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showFood") {
            let FoodViewController = segue.destinationViewController as! DisplayViewController
            println("selectedFood: \(selectedFood)")
//            FoodViewController.loadView()
            FoodViewController.note = selectedFood
        }
        if (segue.identifier == "backHome") {
            let FoodViewController = segue.destinationViewController as! HomeViewController
            IngredientHelper.createString()
        }
    }
    
    func searchNotes(searchString: String) -> RLMResults {
        let realm = Realm()
        let searchPredicate = NSPredicate(format: "name CONTAINS[c] %@ OR group CONTAINS[c] %@", searchString, searchString)
        return FoodInfo.objectsWithPredicate(searchPredicate)
    }
    
}
extension SearchViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        
        //selectedFood = allFoods.objectAtIndex(UInt(indexPath.row)) as? FoodInfo
        selectedFood = notes.objectAtIndex(UInt(indexPath.row)) as? FoodInfo
        self.performSegueWithIdentifier("showFood", sender: self)
    }
   // func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
   //     self.performSegueWithIdentifier("showFood", sender: self)
   // }
}
extension SearchViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FoodCell", forIndexPath: indexPath) as! FoodTableViewCell //1
        
        let row = indexPath.row
        //if state == .DefaultMode{
        //    cell.nameLabel?.text = allFoods[UInt(row)].name
        //}
        //else{
        //notes = allFoods.sortedResultsUsingProperty("name", ascending: true)
            if let notes = notes{
                cell.nameLabel?.text = notes[UInt(row)].name
            }
            
        //}
        //tableView.reloadData()
        //cell.foodnote = allFoods[UInt(row)] as! FoodInfo//JsonHelper.foodsArr[row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return Int(allFoods.count)
        if let notes = notes{
            return Int(notes.count)
        }
        else{
            return 0
        }
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        println("You selected cell #\(indexPath.row)!")
//        self.performSegueWithIdentifier("showFood", sender: self)
//    }
    
    
}
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        state = .SearchMode
    }
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        state = .DefaultMode
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        state = .DefaultMode
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        state = .SearchMode
        //searchBar.resignFirstResponder()
    }
    //func searchBar(searchBar: UISearchBar) {
    //    state = .DefaultMode
    //}
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        notes = searchNotes(searchText)
        //filtered = allFoods.filter({ (text) -> Bool in
        //    let tmp: NSString = text.name
         //   let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
         //   return range.location != NSNotFound
       //})
        //if(filtered.count == 0){
        //    state = .DefaultMode
        //} else {
        //    state = .SearchMode
        //}
        self.tableView.reloadData()
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        notes = allFoods.sortedResultsUsingProperty("name", ascending: true)
    }
}
