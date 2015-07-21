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
    //var ingredients: [FoodInfo]! = []
    var tmpIngredient : FoodInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let tmpIngredient = tmpIngredient{
        IngredientHelper.ingredients.append(tmpIngredient)
        if let ingredientLabel = ingredientLabel{
            println("Ingredients has\(IngredientHelper.ingredients.count)elements")
            IngredientHelper.createString()
            println(IngredientHelper.ingredStr)
            ingredientLabel.text = IngredientHelper.ingredStr
//            for i in 0..<IngredientHelper.ingredients.count{
//                if IngredientHelper.ingredients.count>1 {
//                    ingredientLabel.text = "\(IngredientHelper.ingredients[i].name)\n\n\(ingredientLabel.text)"
//                }
//                else{
//                    ingredientLabel.text = "\(IngredientHelper.ingredients[i].name)"
//                }
//            }
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
