//
//  FirstViewController.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/10/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit
import RealmSwift
import ConvenienceKit

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
    let realm = Realm()
    enum State {
        case DefaultMode
        case SearchMode
    }
    var selectedFood: FoodInfo?
    let vegPredicate = NSPredicate(format: "group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@", "Dairy and Egg Products","Spices and Herbs","Baby Foods","Fats and Oils","Soups, Sauces, and Gravies","Breakfast Cereals","Fruits and Fruit Juices","Vegetables and Vegetable Products","Nut and Seed Products","Beverages","Legumes and Legume Products","Baked Products","Snacks","Sweets","Cereal Grains and Pasta","Fast Foods","Meals Entrees and Side Dishes")
    //var IngredientHelper.tmpCategory : String! = ""
//    var IngredientHelper.sortCat : String! = "name"
//    var IngredientHelper.ascendDescend : Bool = true
    var state: State = .DefaultMode{
        didSet{
        switch (state) {
        case .DefaultMode:
            if(realm.objects(Settings)[0].showMeat == true){
                categoryTitle.title = "All Foods"
            }
            else{
                categoryTitle.title = "All Vegetarian Foods"
            }
            if(IngredientHelper.tmpCategory != ""){
                let convertedCat = convertCat(IngredientHelper.tmpCategory)
                //if(IngredientHelper.tmpCategory != ""){
                    notes = filterNotes(convertedCat,searchString:"")
               // }
               // else{
                    //notes = allFoods.sorted(IngredientHelper.sortCat, ascending: IngredientHelper.ascendDescend)
               // }
                tableView.reloadData()
            }
            else{
                notes = allFoods.sorted(IngredientHelper.sortCat, ascending: IngredientHelper.ascendDescend)
            }
            searchBar.resignFirstResponder()
            searchBar.text = ""
            searchBar.showsCancelButton = false
        case .SearchMode:
            let searchText = searchBar?.text ?? ""
            //carrySearchText = searchText as String?
            searchBar.setShowsCancelButton(true, animated: true)
            if(IngredientHelper.tmpCategory != ""){
                notes = searchNotes(searchText)
                let convertedCat = convertCat(IngredientHelper.tmpCategory)
                if(IngredientHelper.tmpCategory != ""){
                    notes = filterNotes(convertedCat,searchString:"")
                }
                else{
                    notes = allFoods.sorted(IngredientHelper.sortCat, ascending: IngredientHelper.ascendDescend)
                }
                notes = notes.sorted(IngredientHelper.sortCat, ascending: IngredientHelper.ascendDescend)
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
        tableView.dataSource = self
        println("settings.showMeat\(realm.objects(Settings)[0].showMeat)")
        //if(IngredientHelper.tmpCategory != ""){
            println("filtering")
            let convertedCat = convertCat(IngredientHelper.tmpCategory)
            if(IngredientHelper.tmpCategory != ""){
                println("IngredientHelper.tmpCategory \(IngredientHelper.tmpCategory)")
                println("IngredientHelper.convertedCategory \(convertedCat)")
                notes = filterNotes(convertedCat,searchString:"")
                println(notes)
                tableView.reloadData()
                categoryTitle.title = IngredientHelper.tmpCategory
            }
            else{
                println("IngredientHelper.tmpCategory null")
                if(realm.objects(Settings)[0].showMeat == true){
                    notes = allFoods.sorted(IngredientHelper.sortCat, ascending: IngredientHelper.ascendDescend)
                }
                else{
                    notes = allFoods.filter(vegPredicate).sorted(IngredientHelper.sortCat, ascending: IngredientHelper.ascendDescend)
                }
                if(IngredientHelper.sortCat != "name"){
                    categoryTitle.title = IngredientHelper.mapAminoVars(IngredientHelper.sortCat)
                }
                else{
                    if(realm.objects(Settings)[0].showMeat == true){
                        categoryTitle.title = "All Foods"
                    }
                    else{
                        categoryTitle.title = "All Vegetarian Foods"
                    }
                }
            }
            
//            if(realm.objects(Settings)[0].showMeat == true){
//                notes = allFoods.sorted(IngredientHelper.sortCat, ascending: IngredientHelper.ascendDescend)
//            }
            if realm.objects(Settings)[0].showMeat == false{
                notes = allFoods.filter(vegPredicate).sorted(IngredientHelper.sortCat, ascending: IngredientHelper.ascendDescend)
            }
            tableView.reloadData()
//        }
//        //notes = allFoods
//        else{
//            notes = allFoods.sorted(IngredientHelper.sortCat, ascending: IngredientHelper.ascendDescend)
//        }
        // Do any additional setup after loading the view, typically from a nib.
        //tableView.dataSource = self
        
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
        var predArr : [NSPredicate]?
        var searchWords : [String] = split(searchString) {$0 == " "}
        //for i in 0..<searchWords.count{
            //println("searchWords[\(i)]\(searchWords[i])")
        //}
        for i in 0..<searchWords.count{
                if i == 0{
                    predArr = [NSPredicate(format: "name CONTAINS[c] %@",searchWords[i],searchWords[i])]
                }
                else{
                    predArr!.append(NSPredicate(format: "name CONTAINS[c] %@",searchWords[i],searchWords[i]))
                }
            //}
        }
        var ret = realm.objects(FoodInfo)
        if realm.objects(Settings)[0].showMeat == false{
//            let vegPredicate = NSPredicate(format: "group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@ OR group CONTAINS[c] %@", "Dairy and Egg Products","Spices and Herbs","Baby Foods","Fats and Oils","Soups, Sauces, and Gravies","Breakfast Cereals","Fruits and Fruit Juices","Vegetables and Vegetable Products","Nut and Seed Products","Beverages","Legumes and Legume Products","Baked Products","Snacks","Sweets","Cereal Grains and Pasta","Fast Foods","Meals Entrees and Side Dishes")
            ret = ret.filter(vegPredicate)
        }
        if let predArr = predArr {
            for i in 0..<predArr.count{
                ret = ret.filter(predArr[i])
            }
        }
        return ret
    }
    
    func filterNotes(tmpCategory: String, searchString: String) -> Results<FoodInfo> {
        let realm = Realm()
        let convertedCat = convertCat(tmpCategory)
        let categoryPredicate = NSPredicate(format: "group CONTAINS[c] %@", convertedCat)
        var predArr : [NSPredicate]?
        var searchWords : [String] = split(searchString) {$0 == " "}
        for i in 0..<searchWords.count{
            //println("searchWords[\(i)]\(searchWords[i])")
        }
        for i in 0..<searchWords.count{
                if i == 0{
                    predArr = [NSPredicate(format: "name CONTAINS[c] %@",searchWords[i],searchWords[i])]
                }
                else{
                    predArr!.append(NSPredicate(format: "name CONTAINS[c] %@",searchWords[i],searchWords[i]))
                }
        }
        if predArr !=  nil{
              var ret = realm.objects(FoodInfo).filter(categoryPredicate)
            for i in 0..<predArr!.count{
                ret = ret.filter(predArr![i])
                //println(ret)
            }
            return ret
        }
        else{
            //println(realm.objects(FoodInfo).filter(categoryPredicate))
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
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if(IngredientHelper.tmpCategory != ""){
            let convertedCat = convertCat(IngredientHelper.tmpCategory)
            if(convertedCat != ""){
                notes = filterNotes(convertedCat,searchString:searchText)
            }
            else{
                notes = searchNotes(searchText)
            }
//            if(IngredientHelper.tmpCategory == "Soups and Sauces"){
//                notes = filterNotes("Soups Sauces and Gravies",searchString:searchText)
//            }
//            else if(IngredientHelper.tmpCategory == "All Foods"){
//                notes = searchNotes(searchText)
//                //notes = filterNotes("",searchString:"")
//            }
//            else if(IngredientHelper.tmpCategory == "Sausages, etc."){
//                notes = filterNotes("Sausages and Luncheon Meats",searchString:searchText)
//            }
//            else if(IngredientHelper.tmpCategory == "Baked Goods"){
//                notes = filterNotes("Baked Products",searchString:searchText)
//            }
//            else if(IngredientHelper.tmpCategory == "Lamb, Veal, Game"){
//                notes = filterNotes("Lamb Veal and Game Products",searchString:searchText)
//            }
//            else if(IngredientHelper.tmpCategory == "Nuts and Seeds"){
//                notes = filterNotes("Nut and Seed Products",searchString:searchText)
//            }
//            else{
//                notes = filterNotes(IngredientHelper.tmpCategory,searchString:searchText)
//            }
            notes = notes.sorted(IngredientHelper.sortCat, ascending: IngredientHelper.ascendDescend)
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
        notes = allFoods.sorted(IngredientHelper.sortCat, ascending: IngredientHelper.ascendDescend)
    }
    @IBAction func indexChanged(sender:UISegmentedControl){
        switch sortSeg.selectedSegmentIndex{
            case 0:
                IngredientHelper.sortCat = "name"
                IngredientHelper.ascendDescend = true
            case 1:
                IngredientHelper.sortCat = "protGram"
                IngredientHelper.ascendDescend = false
            case 2:
                IngredientHelper.sortCat = "nitFactor"
                IngredientHelper.ascendDescend = false
            default:
            break;
        }
        notes = notes.sorted(IngredientHelper.sortCat, ascending: IngredientHelper.ascendDescend)
        tableView.reloadData()
    }
    func convertCat(tmpCategory : String) -> String {
        switch(tmpCategory){
            case "Soups and Sauces":
                return "Soups Sauces and Gravies"
            case "Sausages, etc.":
                return "Sausages and Luncheon Meats"
            case "Baked Goods":
                return "Baked Products"
            case "Lamb, Veal, Game":
                return "Lamb Veal and Game Products"
            case "Nuts and Seeds":
                return "Nut and Seed Products"
            case "All Foods":
                return ""
            default:
                return tmpCategory
        }
    }
}
