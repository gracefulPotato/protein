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
        var imgNames : [String] = split(matchImageName) {$0 == " "}
        broadSugLabel.text = "\(originalFood.name)\n\nis complemented by\n\n\(matchCat)"
        let displayVC = DisplayViewController()
        var origImg = UIImageView(frame: CGRectMake(100, 350, 50, 50));
        origImg.image = UIImage(named: displayVC.getImage(originalFood.group))
        self.view.addSubview(origImg)
        
        println("\nimgNames.count: \(imgNames.count)")
        for i in 0..<imgNames.count{
            println("i: \(i)")
            var matchImg : UIImageView
//            if i == 0{
//                matchImg = UIImageView(frame: CGRect(x:200, y:(300), width:50, height:50));
//            }
            if i % 2 == 0{
                println("i is even")
                matchImg = UIImageView(frame: CGRect(x:200, y:(350-60*(i/2)), width:50, height:50));
            }
            else{
                println("i is odd")
                if i == 3{
                    matchImg = UIImageView(frame: CGRect(x:200, y:(350+60*(i-1)), width:50, height:50));
                }
                else{
                    matchImg = UIImageView(frame: CGRect(x:200, y:(350+60*i), width:50, height:50));
                }
            }
            matchImg.image = UIImage(named: imgNames[i])
            self.view.addSubview(matchImg)
        }
        
        var plus = UIImageView(frame: CGRectMake(160, 360, 30, 30));
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
        case "Dairy and Egg Products":
            return ("Nuts, legumes, or grains","pistachio.png Peas_32.png Wheat_32.png")
        case "Spices and Herbs":
            return ("Any high-protein food group","Peas_32.png Chicken_32.png pistachio.png Salami_32.png fish_32.png")
        case "Baby Foods":
            if food.protGram > 8{
                return ("Any food group (already has complete protein","Grapes_32.png Broccoli_32.png beverage_32.png")
            }else{
                return ("Any high-protein food group","Peas_32.png Chicken_32.png pistachio.png Salami_32.png fish_32.png")
            }
        case "Fats and Oils":
            if food.protGram > 8{
                return ("Any food group (already has complete protein","Grapes_32.png Broccoli_32.png beverage_32.png")
            }else{
                return ("Any high-protein food group","Peas_32.png Chicken_32.png pistachio.png Salami_32.png fish_32.png")
            }
        case "Poultry Products":
            return ("Any food group (already has complete protein","Grapes_32.png Broccoli_32.png beverage_32.png")
            //return ("Baked Products or Grains","Wheat_32.png")
        case "Soups Sauces and Gravies":
            if food.protGram > 8{
                return ("Any food group (already has complete protein","Grapes_32.png Broccoli_32.png beverage_32.png")
            }else{
                return ("Any high-protein food group","Peas_32.png Chicken_32.png pistachio.png Salami_32.png fish_32.png")
            }
        case "Sausages and Luncheon Meats":
            return ("Any food group (already has complete protein","Grapes_32.png Broccoli_32.png beverage_32.png")
            //return ("Baked Products or Grains","Wheat_32.png")
        case "Breakfast Cereals":
            return ("Dairy, nuts, or legumes","Piece_of_cheese_32.png pistachio.png Peas_32.png")
        case "Fruits and Fruit Juices":
            return ("Any high-protein food group","Peas_32.png Chicken_32.png pistachio.png Salami_32.png fish_32.png")
        case "Pork Products":
            return ("Any food group (already has complete protein","Grapes_32.png Broccoli_32.png beverage_32.png")
            //return ("Baked Products or Grains","Wheat_32.png")
        case "Vegetables and Veg. Products":
            return ("Baked Products or Grains","Wheat_32.png")
        case "Nut and Seed Products":
            return ("Grains, legumes, or dairy","Wheat_32.png Peas_32.png Piece_of_cheese_32.png")
        case "Beef Products":
            return ("Any food group (already has complete protein","Grapes_32.png Broccoli_32.png beverage_32.png")
            //return ("Baked Products or Grains","Wheat_32.png")
        case "Beverages":
            return ("Any high-protein food group","Peas_32.png Chicken_32.png pistachio.png Salami_32.png fish_32.png")
        case "Finfish and Shellfish Products":
            return ("Any food group (already has complete protein","Grapes_32.png Broccoli_32.png beverage_32.png")
            //return ("Baked Products or Grains","Wheat_32.png")
        case "Legumes and Legume Products":
            return ("Grains, nuts, or dairy","Wheat_32.png pistachio.png Piece_of_cheese_32.png")
        case "Lamb, Veal, and Game Products":
            return ("Any food group (already has complete protein","Grapes_32.png Broccoli_32.png beverage_32.png")
            //return ("Baked Products or Grains","Wheat_32.png")
        case "Baked Products":
            return ("Legumes, dairy, or nuts","Peas_32.png Piece_of_cheese_32.png pistachio.png")
        case "Snacks":
            return ("Any high-protein food group","Peas_32.png Chicken_32.png pistachio.png Salami_32.png fish_32.png")
        case "Sweets":
            return ("Any high-protein food group","Peas_32.png Chicken_32.png pistachio.png Salami_32.png fish_32.png")
        case "Cereal Grains and Pasta":
            return ("Legumes, dairy, or nuts","Peas_32.png Piece_of_cheese_32.png pistachio.png")
        case "Fast Foods":
            if food.protGram > 8{
                return ("Any food group (already has complete protein","Grapes_32.png Broccoli_32.png beverage_32.png")
            }else{
                return ("Any high-protein food group","Peas_32.png Chicken_32.png pistachio.png Salami_32.png fish_32.png")
            }
        case "Meals Entrees and Side Dishes":
            if food.protGram > 8{
                return ("Any food group (already has complete protein","Grapes_32.png Broccoli_32.png beverage_32.png")
            }else{
                return ("Any high-protein food group","Peas_32.png Chicken_32.png pistachio.png Salami_32.png fish_32.png")
            }
        default:
            if food.protGram > 8{
                return ("Any food group (already has complete protein","Grapes_32.png Broccoli_32.png beverage_32.png")
            }else{
                return ("Any high-protein food group","Peas_32.png Chicken_32.png pistachio.png Salami_32.png fish_32.png")
            }
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
