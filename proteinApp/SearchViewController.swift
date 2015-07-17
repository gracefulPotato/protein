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
    let allFoods : RLMResults = FoodInfo.allObjects()
    
    enum State {
        case DefaultMode
        case SearchMode
    }
    var selectedFood: FoodInfo?
    var state: State = .DefaultMode
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
        //items.append(Static.f1.name)
        //for i in 1...181{
        //    var varname = "f\(i)"
        //    foods.append(Static.f1)
        //}
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        

        
        //        InfoHelper.printFoods()
        //        let f783 : FoodInfo = FoodInfo(name:"Peaches, canned, heavy syrup pack, solids and liquids",group:"Fruits and Fruit Juices",factor:3.36,nitFactor:6.25,protGram:0.45,tryp:0.001,thre:0.018,isol:0.013,leuc:0.026,lysi:0.015,meth:0.011,phen:0.014,vali:0.025,hist:0.008)
        //        let realm = Realm() // 1
        //        realm.write() { // 2
        //            realm.add(f783) // 3
        //        }
        //        notes = realm.objects(FoodInfo)
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
            FoodViewController.note = selectedFood
        }
    }

    //func searchNotes(searchString: String) -> Results<FoodInfo> {
    //let realm = Realm()
    //let searchPredicate = NSPredicate(format: "name CONTAINS[c] %@ OR content CONTAINS[c] %@", searchString, searchString)
    //return realm.objects(Note).filter(searchPredicate)
    //}
    
}
extension SearchViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        
        selectedFood = allFoods.objectAtIndex(UInt(indexPath.row)) as? FoodInfo
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
        
        cell.nameLabel?.text = allFoods[UInt(row)].name
        
        cell.foodnote = allFoods[UInt(row)] as! FoodInfo//JsonHelper.foodsArr[row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return holdFoodArray.foods.count
        

        return Int(allFoods.count)
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
        state = .DefaultMode
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        //notes = searchNotes(searchText)
        filtered = holdFoodArray.foods.filter({ (text) -> Bool in
            let tmp: NSString = text.name
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            state = .DefaultMode
        } else {
            state = .SearchMode
        }
        self.tableView.reloadData()
    }
    
}
struct holdFoodArray{
    static var foods = [FoodInfo]()
}
