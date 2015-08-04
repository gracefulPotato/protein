//
//  FirstViewController.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/10/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var toolbarBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var categoryTitle: UINavigationItem!
    @IBOutlet weak var sortSeg : UISegmentedControl!
    
    var allFoods: Results<FoodInfo> = { let realm = Realm(); return realm.objects(FoodInfo); } ()
    var carrySearchText : String?
    var resultsArr = [FoodInfo]()
    var keyboardNotificationHandler: KeyboardNotificationHandler?
    enum State {
        case DefaultMode
        case SearchMode
    }
    var selectedFood: FoodInfo?
    var tmpCategory : String! = ""
    var sortCat : String! = "name"
    var ascendDescend : Bool = true
    var state: State = .DefaultMode{
        didSet{
        switch (state) {
        case .DefaultMode:
            categoryTitle.title = "All Foods"
            if(tmpCategory != ""){
                if(tmpCategory == "Soups and Sauces"){
                    notes = filterNotes("Soups Sauces and Gravies",searchString:"")
                }
                else if(tmpCategory == "All Foods"){
                    //notes = searchNotes(searchString)
                    //notes = filterNotes("",searchString:"")
                    notes = notes.sorted(sortCat, ascending: ascendDescend)
                }
                else if(tmpCategory == "Sausages, etc."){
                    notes = filterNotes("Sausages and Luncheon Meats",searchString:"")
                }
                else if(tmpCategory == "Baked Goods"){
                    notes = filterNotes("Baked Products",searchString:"")
                }
                else if(tmpCategory == "Lamb, Veal, Game"){
                    notes = filterNotes("Lamb Veal and Game Products",searchString:"")
                }
                else if(tmpCategory == "Nuts and Seeds"){
                    notes = filterNotes("Nut and Seed Products",searchString:"")
                }
                else{
                    notes = filterNotes(tmpCategory,searchString:"")
                }
                tableView.reloadData()
            }
            else{
                notes = allFoods.sorted(sortCat, ascending: ascendDescend)
            }
            //self.navigationController!.setNavigationBarHidden(false, animated: true)
            searchBar.resignFirstResponder()
            searchBar.text = ""
            searchBar.showsCancelButton = false
        case .SearchMode:
            let searchText = searchBar?.text ?? ""
            //carrySearchText = searchText as String?
            searchBar.setShowsCancelButton(true, animated: true)
            if(tmpCategory != ""){
                notes = searchNotes(searchText)
                if(tmpCategory == "Soups and Sauces"){
                    notes = filterNotes("Soups Sauces and Gravies",searchString:searchText)
                }
                else if(tmpCategory == "All Foods"){
                    notes = searchNotes(searchText)
                    //notes = filterNotes("",searchString:"")
                    notes = notes.sorted(sortCat, ascending:ascendDescend)
                }
                else if(tmpCategory == "Sausages, etc."){
                    notes = filterNotes("Sausages and Luncheon Meats",searchString:searchText)
                }
                else if(tmpCategory == "Baked Goods"){
                    notes = filterNotes("Baked Products",searchString:searchText)
                }
                else if(tmpCategory == "Lamb, Veal, Game"){
                    notes = filterNotes("Lamb Veal and Game Products",searchString:searchText)
                }
                else if(tmpCategory == "Nuts and Seeds"){
                    notes = filterNotes("Nut and Seed Products",searchString:searchText)
                }
                else{
                    notes = filterNotes(tmpCategory,searchString:searchText)
                }
                notes = notes.sorted(sortCat, ascending: ascendDescend)
                tableView.reloadData()
            }
            else{
                notes = searchNotes(searchText)
            }
        }
        }
    }
    var filtered:[FoodInfo] = []
    //static var foods = [FoodInfo]()
    
    var notes: Results<FoodInfo>! {
        didSet {
            // Whenever notes update, update the table view
            if let tableView = tableView {
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(tmpCategory != ""){
            println("filtering")
            if(tmpCategory == "Soups and Sauces"){
                notes = filterNotes("Soups Sauces and Gravies",searchString:"")
            }
            else if(tmpCategory == "All Foods"){
                notes = allFoods.sorted("name", ascending: ascendDescend)
            }
            else if(tmpCategory == "Sausages, etc."){
                notes = filterNotes("Sausages and Luncheon Meats",searchString:"")
            }
            else if(tmpCategory == "Baked Goods"){
                notes = filterNotes("Baked Products",searchString:"")
            }
            else if(tmpCategory == "Lamb, Veal, Game"){
                notes = filterNotes("Lamb Veal and Game Products",searchString:"")
            }
            else if(tmpCategory == "Nuts and Seeds"){
                notes = filterNotes("Nut and Seed Products",searchString:"")
            }
            else{
                notes = filterNotes(tmpCategory,searchString:"")
            }
            categoryTitle.title = tmpCategory
            notes = notes.sorted(sortCat, ascending: ascendDescend)
            tableView.reloadData()
        }
        //notes = allFoods
        else{
            notes = allFoods.sorted(sortCat, ascending: ascendDescend)
        }
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
            FoodViewController.note = selectedFood
        }
        if (segue.identifier == "backHome") {
            let FoodViewController = segue.destinationViewController as! HomeViewController
            IngredientHelper.createString()
        }
    }
    
    func searchNotes(searchString: String) -> Results<FoodInfo> {
        let realm = Realm()
        let searchPredicate = NSPredicate(format: "name CONTAINS[c] %@ OR group CONTAINS[c] %@", searchString, searchString)
        //return FoodInfo.objectsWithPredicate(searchPredicate)
        var predArr : [NSPredicate]?
        var searchWords : [String] = split(searchString) {$0 == " "}
        for i in 0..<searchWords.count{
            println(searchWords[i])
        }
        for i in 0..<searchWords.count{
            if i == 0{
                predArr = [NSPredicate(format: "name CONTAINS[c] %@ OR group CONTAINS[c] %@",searchWords[i],searchWords[i])]
            }
            else{
                predArr!.append(NSPredicate(format: "name CONTAINS[c] %@ OR group CONTAINS[c] %@",searchWords[i],searchWords[i]))
            }
        }
        var ret = realm.objects(FoodInfo)
        if let predArr = predArr {
            //var ret = FoodInfo.allObjects()
            for i in 0..<predArr.count{
                ret = ret.filter(predArr[i])
                println(ret)
            }
            
        }
        return ret
    }
    
    func filterNotes(tmpCategory: String, searchString: String) -> Results<FoodInfo> {
        let realm = Realm()
        let categoryPredicate = NSPredicate(format: "group CONTAINS[c] %@", tmpCategory)
        var predArr : [NSPredicate]?
        var searchWords : [String] = split(searchString) {$0 == " "}
        for i in 0..<searchWords.count{
            println(searchWords[i])
        }
        for i in 0..<searchWords.count{
            if i == 0{
                predArr = [NSPredicate(format: "name CONTAINS[c] %@ OR group CONTAINS[c] %@",searchWords[i],searchWords[i])]
            }
            else{
                predArr!.append(NSPredicate(format: "name CONTAINS[c] %@ OR group CONTAINS[c] %@",searchWords[i],searchWords[i]))
            }
        }
        if predArr !=  nil{
              var ret = realm.objects(FoodInfo).filter(categoryPredicate)
            for i in 0..<predArr!.count{
                ret = ret.filter(predArr![i])
                println(ret)
            }
            return ret
        }
        else{
            return realm.objects(FoodInfo).filter(categoryPredicate)
        }
    }
    
}
extension SearchViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //selectedFood = allFoods.objectAtIndex(UInt(indexPath.row)) as? FoodInfo
        selectedFood = notes[indexPath.row]
        self.performSegueWithIdentifier("showFood", sender: self)
    }
   // func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
   //     self.performSegueWithIdentifier("showFood", sender: self)
   // }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
            return false
    }
}
extension SearchViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FoodCell", forIndexPath: indexPath) as! FoodTableViewCell //1
        
        let row = indexPath.row
        if let notes = notes{
            cell.nameLabel?.text = notes[row].name
        }
        
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
        if(tmpCategory != ""){
            if(tmpCategory == "Soups and Sauces"){
                notes = filterNotes("Soups Sauces and Gravies",searchString:searchText)
            }
            else if(tmpCategory == "All Foods"){
                notes = searchNotes(searchText)
                //notes = filterNotes("",searchString:"")
            }
            else if(tmpCategory == "Sausages, etc."){
                notes = filterNotes("Sausages and Luncheon Meats",searchString:searchText)
            }
            else if(tmpCategory == "Baked Goods"){
                notes = filterNotes("Baked Products",searchString:searchText)
            }
            else if(tmpCategory == "Lamb, Veal, Game"){
                notes = filterNotes("Lamb Veal and Game Products",searchString:searchText)
            }
            else if(tmpCategory == "Nuts and Seeds"){
                notes = filterNotes("Nut and Seed Products",searchString:searchText)
            }
            else{
                notes = filterNotes(tmpCategory,searchString:searchText)
            }
            notes = notes.sorted(sortCat, ascending: ascendDescend)
            tableView.reloadData()
        }
        else{
            notes = searchNotes(searchText)
        }
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
        notes = allFoods.sorted(sortCat, ascending: ascendDescend)
    }
    @IBAction func indexChanged(sender:UISegmentedControl){
        switch sortSeg.selectedSegmentIndex{
            case 0:
                sortCat = "name"
                ascendDescend = true
            case 1:
                sortCat = "protGram"
                ascendDescend = false
            case 2:
                sortCat = "nitFactor"
                ascendDescend = false
            default:
            break;
        }
        notes = notes.sorted(sortCat, ascending: ascendDescend)
        tableView.reloadData()
    }
}
