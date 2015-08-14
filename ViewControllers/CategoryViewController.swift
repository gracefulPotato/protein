//
//  CategoryViewController.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/21/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    let catArr : [[String]] = [["All Foods","Dairy and Egg","Spices and Herbs","Baby Foods","Fats and Oils","Poultry","Soups and Sauces","Sausages, etc.","Breakfast Cereal","Fruit","Pork","Vegetables","Nuts and Seeds","Beef","Beverages","Fish","Legumes","Lamb, Veal, Game","Baked Goods","Snacks","Sweets","Grains and Pasta","Fast Food","Meals"]]
    let noMeatArr : [[String]] = [["All Foods","Dairy and Egg","Spices and Herbs","Baby Foods","Fats and Oils","Soups and Sauces","Breakfast Cereal","Fruit","Vegetables","Nuts and Seeds","Beverages","Legumes","Baked Goods","Snacks","Sweets","Grains and Pasta","Fast Food","Meals"]]
    let imgNameArr : [[String]] = [["Searching_magnifying_glass_32.png","Piece_of_cheese_32.png","Herbal_32.png","baby_32.png","Olive_32.png","Chicken_32.png","Soup_32.png","Salami_32.png","Cereals_32.png","Grapes_32.png","Bacon_32.png","Broccoli_32.png","pistachio.png","steak_32.png","beverage_32.png","fish_32.png","Peas_32.png","Deer_32.png","Cookies_32.png","Chips_32.png","Candy_32.png","Wheat_32.png","Fast_Food_32.png","rice_32.png"]]
    let noMeatImgArr : [[String]] = [["Searching_magnifying_glass_32.png","Piece_of_cheese_32.png","Herbal_32.png","baby_32.png","Olive_32.png","Soup_32.png","Cereals_32.png","Grapes_32.png","Broccoli_32.png","pistachio.png","beverage_32.png","Peas_32.png","Cookies_32.png","Chips_32.png","Candy_32.png","Wheat_32.png","Fast_Food_32.png","rice_32.png"]]
    let reuseIdentifier = "CategoryCell"
    var selectedCat : String = ""
    var prevcell : UICollectionViewCell!
    let realm = Realm()
    var alert = UIAlertController(title: "Warning! Database loading, please do not close the app.", message: "This will ONLY occur the FIRST time Amino Ally is opened. The first few categories will load more quickly.", preferredStyle: UIAlertControllerStyle.Alert)
    @IBOutlet weak var catView : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addAlertAction()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if(realm.objects(Settings)[0].showMeat == true){
            return 24//catArr[0].count //25
        }
        else{
            return noMeatArr[0].count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //cell.contentView.subviews.makeObjectsPerformSelector:@selector(removeFromSuperview)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier( reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()
        // Configure the cell
        var title = UILabel(frame: CGRectMake(cellWidth()/20, 0, cell.bounds.size.width, 40))
        var image : UIImage!
        if(realm.objects(Settings)[0].showMeat){
            image = UIImage(named: imgNameArr[indexPath.section][indexPath.row])
            title.text = catArr[indexPath.section][indexPath.row]
            
        }
        else{
            image = UIImage(named: noMeatImgArr[indexPath.section][indexPath.row])
            title.text = noMeatArr[indexPath.section][indexPath.row]
        }
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: cellWidth()-40, y: 5, width: 32, height: 32)
        cell.contentView.addSubview(imageView)
        cell.contentView.addSubview(title)
        
        
        prevcell = cell
        return cell
    }
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            var size = CGSize(width: cellWidth(), height: 40)
            if(catArr[indexPath.section][indexPath.row] == "All Foods"){
                size = CGSize(width: cellWidth()*2 + 16, height: 40)
            }
            return size
    }
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier( reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        cell.removeFromSuperview()
    }
    func cellWidth() -> CGFloat{
        var sizeRect = UIScreen.mainScreen().applicationFrame
        var width    = sizeRect.size.width
        var height   = sizeRect.size.height
        let cellWidth = (width/2 - 25)
        return cellWidth
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "CategoryButtonTapped") {


            let FoodViewController = segue.destinationViewController as! SearchViewController
            assert(sender as? UICollectionViewCell != nil, "sender is not a collection view")
            var cell : UICollectionViewCell = sender as! UICollectionViewCell
            if let indexPath = self.catView?.indexPathForCell(cell) {
                if(realm.objects(FoodInfo).count < 50){
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else if(realm.objects(FoodInfo).count < 500 && indexPath.row > 4){
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else if(realm.objects(FoodInfo).count < 1000 && indexPath.row > 6){
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else if(realm.objects(FoodInfo).count < 1500 && indexPath.row > 8){
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else if(realm.objects(FoodInfo).count < 2000 && indexPath.row > 9){
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else if(realm.objects(FoodInfo).count < 2700 && indexPath.row > 11){
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else if(realm.objects(FoodInfo).count < 3000 && indexPath.row > 14){
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                println("setting selectedCat")
                if(realm.objects(Settings)[0].showMeat == true){
                    selectedCat = catArr[indexPath.section][indexPath.row]
                }
                else{
                    selectedCat = noMeatArr[indexPath.section][indexPath.row]
                }
            }
            
            IngredientHelper.tmpCategory = selectedCat
            println("Selected Category:\(selectedCat)")
            //FoodViewController.ingredients.append(addedFood)
        }
    }
    func addAlertAction(){
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                println("default")
//                if IngredientHelper.ingredients.count > 0{
//                    for i in 0..<IngredientHelper.ingredients.count{
//                        IngredientHelper.ingredients.removeAtIndex(0)
//                    }
//                    self.aminoButton.hidden = true
//                    self.ingredientTable.reloadData()
//                    self.prepareOtherViews()
//                    self.barChartView.reloadData()
                    
                //}
                //self.tmpIngredient = nil
            case .Cancel:
                println("cancel")
                
            case .Destructive:
                println("destructive")
            }
        }))
    }
}
