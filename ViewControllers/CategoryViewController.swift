//
//  CategoryViewController.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/21/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    let catArr : [[String]] = [["Dairy and Egg","Spices and Herbs","Baby Foods","Fats and Oils","Poultry","Soups and Sauces","Sausages, etc.","Breakfast Cereal","Fruit","Pork","Vegetables","Nuts and Seeds","Beef","Beverages","Fish","Legumes","Lamb, Veal, Game","Baked Goods","Snacks","Sweets","Grains and Pasta","Fast Food","Meals"]]
    let imgNameArr : [[String]] = [["Piece_of_cheese_32.png","Herbal_32.png","baby_32.png","Olive_32.png","Chicken_32.png","Soup_32.png","Salami_32.png","Cereals_32.png","Grapes_32.png","Bacon_32.png","Broccoli_32.png","pistachio.png","steak_32.png","beverage_32.png","fish_32.png","Peas_32.png","Deer_32.png","Cookies_32.png","Chips_32.png","Candy_32.png","Wheat_32.png","Fast_Food_32.png","rice_32.png"]]
    let reuseIdentifier = "CategoryCell"
    var selectedCat : String = ""
    
    //@IBOutlet weak var CategoryCell : UICollectionViewCell!
    @IBOutlet weak var catView : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 23//catArr[0].count //25
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier( reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()
        // Configure the cell
        var title = UILabel(frame: CGRectMake(0, 0, cell.bounds.size.width, 40))
        let image = UIImage(named: imgNameArr[indexPath.section][indexPath.row])
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 120, y: 5, width: 32, height: 32)
        title.numberOfLines = 0
        cell.contentView.addSubview(imageView)
        cell.contentView.addSubview(title)
        //let index = indexPath as Int
        title.text = catArr[indexPath.section][indexPath.row]
        //selectedCat = title.text as! String!
        //image = imgArr[indexPath.section][indexPath.row]
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        self.performSegueWithIdentifier("CategoryButtonTapped", sender: self)
//          selectedCat = catArr[indexPath.section][indexPath.row]
//          println("Selected Cat:\(selectedCat)")
//        let FoodViewController = segue.destinationViewController as! SearchViewController
//        FoodViewController.tmpCategory = selectedCat
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "CategoryButtonTapped") {
            //let nav = segue.destinationViewController as! UINavigationController
            //let FoodViewController = nav.topViewController as! SearchViewController
            let FoodViewController = segue.destinationViewController as! SearchViewController
            //println("addedFood: \(addedFood)")
            //            FoodViewController.loadView()
            //selectedCat = collectionView.cell.title.text as String //catArr[indexPath.section][indexPath.row]
            //if let indexPath = {
            println("sender\nsender\nsender: \(sender)")
            println("sender.indexPath\(sender!.indexPath)")
            println("\(object_getClass(sender))")
            //println("sender.title: \(sender!.title!.text)")
            assert(sender as? UICollectionViewCell != nil, "sender is not a collection view")
            var cell : UICollectionViewCell = sender as! UICollectionViewCell
            if let indexPath = self.catView?.indexPathForCell(cell) {
                println("setting selectedCat")
                selectedCat = catArr[indexPath.section][indexPath.row]
            }
            
            //}
            FoodViewController.tmpCategory = selectedCat
            println("Selected Category:\(selectedCat)")
            //FoodViewController.ingredients.append(addedFood)
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
