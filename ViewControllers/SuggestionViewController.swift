//
//  SuggestionViewController.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/24/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController {

    @IBOutlet weak var broadSugLabel : UILabel!
    @IBOutlet weak var textView : UITextView!
    @IBOutlet weak var origImg : UIImageView!
    @IBOutlet weak var matchImg : UIImageView!
    var originalFood : FoodInfo!
    var matchCat : String!
    var matchImageName : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        (matchCat, matchImageName) = calcMatchCat(originalFood)
        broadSugLabel.text = "\(originalFood.name)\n\nis complemented by\n\n\(matchCat)"
        let displayVC = DisplayViewController()
        var origImg = UIImageView(frame: CGRectMake(100, 300, 50, 50));
        origImg.image = UIImage(named: displayVC.getImage(originalFood.group))
        self.view.addSubview(origImg)
        
        var matchImg = UIImageView(frame: CGRectMake(200, 300, 50, 50));
        matchImg.image = UIImage(named: matchImageName)
        self.view.addSubview(matchImg)
        
        var plus = UIImageView(frame: CGRectMake(150, 300, 40, 40));
        plus.image = UIImage(named: "add.png")
        self.view.addSubview(plus)
        
//        let image = UIImage(named: "Link")
//        let origImg = UIImageView(image: image!)
//        origImg.frame = CGRect(x: 120, y: 5, width: 32, height: 32)
        textView.text = "Randomly generated suggestions:\n - <Food just viewed> and <Food from suggested category>"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calcMatchCat(food:FoodInfo) ->(String!,String!){
        switch food.group{
        case "Dairy and Egg products":
            return ("something","Link")
        case "Spices and Herbs":
            return ("Any high-protein food group","Peas_32.png")
        case "Baby Foods":
            return ("idk","Link")
        case "Fats and Oils":
            return ("Any high-protein food group","Peas_32.png")
        case "Poultry Products":
            return ("Baked Products or Grains","Wheat_32.png")
        case "Soups, Sauces, and Gravies":
            return ("Any high-protein food group","Peas_32.png")
        case "Sausages and Luncheon Meats":
            return ("Baked Products or Grains","Wheat_32.png")
        case "Breakfast Cereals":
            return ("Dairy and Egg products or Nut and Seed Products","Piece_of_cheese_32.png")
        case "Fruits and Fruit Juices":
            return ("Any high-protein food group","Peas_32.png")
        case "Pork Products":
            return ("Baked Products or Grains","Wheat_32.png")
        case "Vegetables and Veg. Products":
            return ("Baked Products or Grains","Wheat_32.png")
        case "Nut and Seed Products":
            return ("Baked Products or Grains","Wheat_32.png")
        case "Beef Products":
            return ("Baked Products or Grains","Wheat_32.png")
        case "Beverages":
            return ("Any high-protein food group","Peas_32.png")
        case "Finfish and Shellfish Products":
            return ("Baked Products or Grains","Wheat_32.png")
        case "Legumes and Legume Products":
            return ("Baked Products or Grains","Wheat_32.png")
        case "Lamb, Veal, and Game Products":
            return ("Baked Products or Grains","Wheat_32.png")
        case "Baked Products":
            return ("Meat, Legumes, Fish, Dairy, or Nuts","steak_32.png")
        case "Snacks":
            return ("Any high-protein food group","Peas_32.png")
        case "Sweets":
            return ("Any high-protein food group","Peas_32.png")
        case "Cereal Grains and Pasta":
            return ("Meat, Legumes, Fish, Dairy, or Nuts","steak_32.png")
        case "Fast Foods":
            return ("idk","Link")
        case "Meals Entrees and Side Dishes":
            return ("idk","Link")
        default:
            return ("idk","Link")
        }
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
