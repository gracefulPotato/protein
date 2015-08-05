//
//  PastRecipesViewController.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/30/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit
import RealmSwift

class PastRecipesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var recipeLabel : UILabel!
    @IBOutlet weak var tableView: UITableView!
    var selectedRecipe: String?//[String?] = []
    var alert = UIAlertController(title: "Deletion Alert", message: "Are you sure you want to clear all recipes?", preferredStyle: UIAlertControllerStyle.Alert)
    var cell : RecipeTableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRecipeLabel()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        addAlertAction()
        //tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func loadRecipeLabel(){
        let realm = Realm()
        if let recipeLabel = recipeLabel{
            println("in conditional")
            recipeLabel.text = ""
            for i in 0..<realm.objects(RecipeWithPicture).count{
                recipeLabel.text = "\(recipeLabel.text)\(RecipeWithPicture(value: realm.objects(RecipeWithPicture)[i]).title)\(RecipeWithPicture(value: realm.objects(RecipeWithPicture)[i]).ingredientStr)\n\n"
                println("recipeLabel.text\(recipeLabel.text)")
            }
            println("realm.objects(RecipeWithPicture).count: \(realm.objects(RecipeWithPicture).count)")
            println(realm.objects(RecipeWithPicture))
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return true
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let realm = Realm()
        cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell", forIndexPath: indexPath) as! RecipeTableViewCell //1
        let row = indexPath.row
        //println("cell.correspondRecipe: \(cell.correspondRecipe)")
        if cell.correspondRecipe == nil{
            cell.correspondRecipe = realm.objects(RecipeWithPicture)[row]
        }
        //println("in conditional")
        cell.recipeTextView.text = nil
        cell.titletextView.text = "\(cell.correspondRecipe.title)"
        cell.recipeTextView.text = "​\u{200B}\(cell.correspondRecipe.ingredientStr)\n\n"
        //cell.correspondRecipe = realm.objects(RecipeWithPicture)[row]
        //println(realm.objects(RecipeWithPicture))
        
        let img = UIImage(data: realm.objects(RecipeWithPicture)[row].picture)
        cell.userMadePic.image = img
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        println("in didSelectRowAtIndexPath")
        let realm = Realm()
        //selectedFood = allFoods.objectAtIndex(UInt(indexPath.row)) as? FoodInfo
        //selectedRecipe[0] = realm.objects(RecipeWithPicture)[indexPath.row].title
        //selectedRecipe = realm.objects(RecipeWithPicture)[indexPath.row].ingredientStr
        IngredientHelper.tmpRecipeStr = realm.objects(RecipeWithPicture)[indexPath.row].ingredientStr
        //println("\n\nselectedRecipe\n\n\(selectedRecipe)")
        //let FoodViewController = HomeViewController()
        //FoodViewController.tmpRecipeStr = selectedRecipe
        //println("FoodViewController.tmpRecipeStr\(FoodViewController.tmpRecipeStr)")
        self.performSegueWithIdentifier("showRecipe", sender: self)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = Realm()
        return realm.objects(RecipeWithPicture).count
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let realm = Realm()
        if editingStyle == .Delete {
            realm.write(){
                realm.delete(realm.objects(RecipeWithPicture)[indexPath.row])
            }
            //realm.objects(RecipeWithPicture).removeObjectAtIndex(indexPath.row)
            //IngredientHelper.ingredients.removeAtIndex(indexPath.row)
            tableView.reloadData()
            
        }
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if (segue.identifier == "showRecipe") {
//            let FoodViewController = segue.destinationViewController as! HomeViewController
//            println("type: \(sender!.recipeTextView.dynamicType)");
//            //selectedRecipe = sender!.recipeTextView.text//ingredientStr
//            println("selectedRecipe\(selectedRecipe)")
//            FoodViewController.tmpRecipeStr = selectedRecipe
//            println("FoodViewController.tmpRecipeStr\(FoodViewController.tmpRecipeStr)")
//        }
//    }
    
    func addAlertAction(){
        alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { action in
            let realm = Realm()
            switch action.style{
            case .Default:
                println("default")
                    realm.write(){
                        realm.delete(realm.objects(RecipeWithPicture))
                    }
                    self.loadRecipeLabel()
                    self.tableView.reloadData()
            case .Cancel:
                println("cancel")
                
            case .Destructive:
                println("destructive")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .Default, handler: { action in
        }))
    }
    @IBAction func deleteButtonPressed(sender:AnyObject){
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        let realm = Realm()
        //let myrow: Int? = tableView.indexPathForCell(RecipeCell : RecipeTableViewCell)//cellCurrentlyEditing(self)
        //realm.objects(RecipeWithPicture)[cell].title = textField.text
        realm.write(){
            self.cell.correspondRecipe.title = textField.text
        }
    }

}
//extension PastRecipesViewController: UITableViewDataSource {
//
//}
