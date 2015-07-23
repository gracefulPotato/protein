//
//  HomeViewController.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/20/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var addFoodButton : UIButton!
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var totalProteinLabel: UILabel!
    @IBOutlet weak var recipeCalcTitleLabel: UILabel!
    @IBOutlet weak var searchButton : UIButton!
    @IBOutlet weak var ingredientTextView : UITextView!
    @IBOutlet weak var reportLabel : UILabel!
    
    //var ingredients: [FoodInfo]! = []
    var tmpIngredient : FoodInfo?
    var levelJudgement : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let tmpIngredient = tmpIngredient{
            println("adding ingredient")
        IngredientHelper.ingredients.append(tmpIngredient)
        //if let ingredientLabel = ingredientLabel{
        if let ingredientTextView = ingredientTextView{
            println("Ingredients has\(IngredientHelper.ingredients.count)elements")
            IngredientHelper.createString()
            println(IngredientHelper.ingredStr)
            //ingredientLabel.text = IngredientHelper.ingredStr
            ingredientTextView.text = IngredientHelper.ingredStr
        }
            if let totalProteinLabel = totalProteinLabel{
                totalProteinLabel.text = "Total protein: \(IngredientHelper.returnProteinTotal()) grams"
            }
            if let reportLabel = reportLabel{
                reportLabel.text = "Progress: \(IngredientHelper.returnLevelJudgement()) amino balance __."
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func addFoodButtonTapped(sender: AnyObject) {
//    self.performSegueWithIdentifier("addFoodButtonTapped", sender: sender)
//
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
