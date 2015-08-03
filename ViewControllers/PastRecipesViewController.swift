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
    @IBOutlet weak var recipeLabel : UITextView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRecipeLabel()
        tableView.dataSource = self
        tableView.reloadData()
    }
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    @IBAction func deleteAllButtonPressed(){
        //delete all realm objects of type RecipeWithPicture
        let realm = Realm()
        println("\(object_getClass(realm.objects(RecipeWithPicture)))")

        realm.write(){
            realm.delete(realm.objects(RecipeWithPicture))
        }
        loadRecipeLabel()
        //recipeLabel.reloadInputViews()
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
        return false
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let realm = Realm()
        let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell", forIndexPath: indexPath) as! RecipeTableViewCell //1
        
        let row = indexPath.row
        println("in conditional")
        cell.recipeTextView.text = nil
        cell.titleLabel.text = "\(RecipeWithPicture(value: realm.objects(RecipeWithPicture)[row]).title)"
        cell.recipeTextView.text = "​\u{200B}\(RecipeWithPicture(value: realm.objects(RecipeWithPicture)[row]).ingredientStr)\n\n"
        println("ingredients: \(RecipeWithPicture(value: realm.objects(RecipeWithPicture)[row]).ingredientStr)")
        println("realm.objects(RecipeWithPicture).count: \(realm.objects(RecipeWithPicture).count)")
        println(realm.objects(RecipeWithPicture))
        
        let img = UIImage(data: realm.objects(RecipeWithPicture)[row].picture)
        cell.userMadePic.image = img
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = Realm()
        return realm.objects(RecipeWithPicture).count
    }
    func documentsPathForFileName(name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true);
        let path = paths[0] as! String;
        let fullPath = path.stringByAppendingPathComponent(name)
        
        return fullPath
    }
    
}
