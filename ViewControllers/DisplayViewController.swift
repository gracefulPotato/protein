//
//  DisplayViewController.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/16/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit
import JBChartView
import RealmSwift

class DisplayViewController: UIViewController, JBBarChartViewDataSource, JBBarChartViewDelegate {
    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleTextField: UILabel!
    @IBOutlet weak var groupTextView: UILabel!
    @IBOutlet weak var protGramTextView: UILabel!
    @IBOutlet weak var foodGroupImage : UIImageView!
    @IBOutlet weak var barChartView : JBBarChartView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var suggestionButton: UIButton!
    
    var addedFood : FoodInfo?
    let myTransparentWhite = UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.5)
    var note: FoodInfo? {
        didSet {
            println("in note didset")
            displayFood(self.note)
            println(self.note!.name)
            println("after calling displayFood")
            
        }
    }
    
    func displayFood(note: FoodInfo?) {
        println("in displayFood")
        if let note = note{
            println("in conditional")
            if let titleTextField = titleTextField, groupTextView = groupTextView, protGramTextView = protGramTextView  {
                println("in inner conditional")
                titleTextField.text = note.name
                println(titleTextField)
                groupTextView.text = "Food Group:\n\(note.group)"
                protGramTextView.text = "Total protein: \(note.protGram) grams"
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        barChartView.backgroundColor = myTransparentWhite
        barChartView.dataSource = self
        barChartView.delegate = self
        println(barChartView.dataSource)
        barChartView.minimumValue = 0
        barChartView.maximumValue = 4
        titleTextField.adjustsFontSizeToFitWidth = true
        //barChartView.frame = CGRectMake(100,100,200,200)
        barChartView.reloadData()
        displayFood(self.note)
        var foodGroupImage = UIImageView(frame: CGRectMake(300, 150, 50, 50));
        foodGroupImage.image = UIImage(named: getImage(note!.group))
        self.view.addSubview(foodGroupImage);
        //informationLabel.text = ""
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // our code
        barChartView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let realm = Realm()
        if (segue.identifier == "AddFoodRecipeButtonTapped") {
            let FoodViewController = segue.destinationViewController as! HomeViewController
            FoodViewController.tmpIngredient = note
            realm.write{
                self.note!.nitFactor = self.note!.nitFactor + 1
            }
        }
        if (segue.identifier == "toSuggestions") {
            let FoodViewController = segue.destinationViewController as! SuggestionViewController
            FoodViewController.originalFood = note
        }
    }
    
    func numberOfBarsInBarChartView(barChartView: JBBarChartView!) -> UInt {
        return 9
    }
    
    func barChartView(barChartView: JBBarChartView!, heightForBarViewAtIndex index: UInt) -> CGFloat {
        switch index{
            case 0:
                return CGFloat(note!.tryp) //0.45 //0.15
            case 1:
                return CGFloat(note!.thre) //1.81 //0.60
            case 2:
                return CGFloat(note!.isol) //1.73 //0.58
            case 3:
                return CGFloat(note!.leuc) //3.82 //1.27
            case 4:
                return CGFloat(note!.lysi) //3.45 //1.15
            case 5:
                return CGFloat(note!.meth) //1.73 //0.58
            case 6:
                return CGFloat(note!.phen) //3.00 //1.00
            case 7:
                return CGFloat(note!.vali) //2.18 //0.73
            case 8:
                return CGFloat(note!.hist) //1.27 //0.42
            default:
                return 0
        }
    }
    
    func barChartView(barChartView: JBBarChartView!, didSelectBarAtIndex index: UInt) {
        if let note = note{
            switch index{
                case 0:
                    informationLabel.text = "Contains \(note.tryp)g Tryptophan"
                case 1:
                    informationLabel.text = "Contains \(note.thre)g Threonine"
                case 2:
                    informationLabel.text = "Contains \(note.isol)g Isoleucine"
                case 3:
                    informationLabel.text = "Contains \(note.leuc)g Leucine"
                case 4:
                    informationLabel.text = "Contains \(note.lysi)g Lysine"
                case 5:
                    informationLabel.text = "Contains \(note.meth)g Methionine"
                case 6:
                    informationLabel.text = "Contains \(note.phen)g Phenylalanine"
                case 7:
                    informationLabel.text = "Contains \(note.vali)g Valine"
                case 8:
                    informationLabel.text = "Contains \(note.hist)g Histidine"
                default:
                    informationLabel.text = "Contains \(note.tryp)g DefaultCase!"
            }
        }
    }
//    func barChartView(barChartView: JBBarChartView!, colorForBarViewAtIndex index: UInt) -> UIColor {
//        return UIColor.blueColor()
//    }
    
    func getImage(groupName: String)->String{
        switch groupName{
        case "Dairy and Egg Products":
            return "Piece_of_cheese_32.png"
        case "Spices and Herbs":
            return "Herbal_32.png"
        case "Baby Foods":
            return "Baby_32.png"
        case "Fats and Oils":
            return "Olive_32.png"
        case "Poultry Products":
            return "Chicken_32.png"
        case "Soups Sauces and Gravies":
            return "Soup_32.png"
        case "Sausages and Luncheon Meats":
            return "Salami_32.png"
        case "Breakfast Cereals":
            return "Cereals_32.png"
        case "Fruits and Fruit Juices":
            return "Grapes_32.png"
        case "Pork Products":
            return "Bacon_32.png"
        case "Vegetables and Vegetable Products":
            return "Broccoli_32.png"
        case "Nut and Seed Products":
            return "pistachio.png"
        case "Beef Products":
            return "steak_32.png"
        case "Beverages":
            return "beverage_32.png"
        case "Finfish and Shellfish Products":
            return "fish_32.png"
        case "Legumes and Legume Products":
            return "Peas_32.png"
        case "Lamb Veal and Game Products":
            return "Deer_32.png"
        case "Baked Products":
            return "Cookies_32.png"
        case "Snacks":
            return "Chips_32.png"
        case "Sweets":
            return "Candy_32.png"
        case "Cereal Grains and Pasta":
            return "Wheat_32.png"
        case "Fast Foods":
            return "Fast_food_32.png"
        case "Meals Entrees and Side Dishes":
            return "rice_32.png"
        default:
            return "rice_32.png"
        }
    }

}
