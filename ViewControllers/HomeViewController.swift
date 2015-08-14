//
//  HomeViewController.swift
//  proteinApp
//
//  Created by Grace O'Hair-Sherman on 7/20/15.
//  Copyright (c) 2015 Grace O'Hair-Sherman. All rights reserved.
//

import UIKit
import JBChartView
import RealmSwift

class HomeViewController: UIViewController, JBBarChartViewDataSource, JBBarChartViewDelegate, UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var addFoodButton : UIButton!
    @IBOutlet weak var totalProteinLabel: UILabel!
    @IBOutlet weak var recipeCalcTitleLabel: UILabel!
    @IBOutlet weak var reportLabel : UILabel!
    @IBOutlet weak var aminoLabel : UILabel!
    @IBOutlet weak var barChartView : JBBarChartView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var ingredientTable : UITableView!
    
    var tmpIngredient : FoodInfo?
    var tmpRecipeStr : String?
    var levelJudgement : String!

    var tryp : Double = 0
    var thre: Double = 0
    var isol : Double = 0
    var leuc: Double = 0
    var lysi : Double = 0
    var meth: Double = 0
    var phen : Double = 0
    var vali: Double = 0
    var hist : Double = 0
    
    let myTransparentWhite = UIColor(red:1.0, green:1.0, blue:1.0, alpha:0.0)
    let myBarColor = UIColor(red:0.7, green:0.1, blue:1, alpha:1.0)
    var displayMeat : Bool!
    var alert = UIAlertController(title: "Deletion Alert", message: "Are you sure you want to clear this recipe?\nIf you haven't saved it, you'll lose it.", preferredStyle: UIAlertControllerStyle.Alert)
    var saveAlert = UIAlertController(title: "Save Recipe?", message: "Clear recipe when done?\n\nEnter recipe title:", preferredStyle: UIAlertControllerStyle.Alert)
    //var saveMessage = UIAlertController(title: "Recipe saved.", message: "Find saved recipes in the Recipe Log found in the hamburger menu.", preferredStyle: UIAlertControllerStyle.Alert)
    var addFoodMessage = UIAlertController(title: "Add ingredients to see total protein", message: "", preferredStyle: UIAlertControllerStyle.Alert)
    
    var selectedFood: FoodInfo?
    let realm = Realm()
    var textField = UITextField(frame: CGRectMake(0, 0, 10, 10))
    var imagePickerController: UIImagePickerController?
    var selectedImage : UIImage!
    var deleteSwitch : UISwitch = UISwitch(frame: CGRectMake(220, 40, 10, 10))
    var noPicture = true
    var photoTakingHelper : PhotoTakingHelper?
    var good : Bool = false
    var aminoText : String = ""
    var aminoColor : UIColor = UIColor.redColor()
    let aminoButton = UIButton()
    var mult : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveAlert.addTextFieldWithConfigurationHandler(configurationTextField)
        saveAlert.view.addSubview(deleteSwitch)
        
        prepareBarChartView()
        if let tmpIngredient = tmpIngredient{
            IngredientHelper.ingredients.append(tmpIngredient)
        }
        if let mult = mult{
            IngredientHelper.multipliers.append(mult)
        }
        if let tmpRecipeStr = IngredientHelper.tmpRecipeStr{
            reloadRecipe(tmpRecipeStr)
        }
        else{
            if IngredientHelper.ingredients.count == 0{
                aminoButton.enabled = false
            }
        }
        prepareOtherViews()
        ingredientTable.reloadData()
        println("displayMeat: \(displayMeat)")
        addAlertAction()
        addSaveAlertAction()
        //addSaveMessageAction()
        addAddFoodMessageAction()
        deleteSwitch.on = true
        if(IngredientHelper.displayMessage == true){
            onFirstStartup()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if IngredientHelper.ingredients.count == 0{
            aminoButton.enabled = false
        }
        // our code
        barChartView.reloadData()
        ingredientTable.reloadData()
        println("displayMeat: \(displayMeat)")
    }
    func onFirstStartup(){
        println("onfirststartup running")
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let titleAction = UIAlertAction(title: "Add ingredients to see total protein!", style: .Default, handler: nil)
        alertController.addAction(titleAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        if let popoverPresentationController = alertController.popoverPresentationController{
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        }
        self.presentViewController(alertController, animated: true, completion: nil)
        //let cameraAction = UIAlertAction(title: "Photo from camera", style: .Default)
        //self.presentViewController(self.addFoodMessage, animated: true, completion: nil)
        IngredientHelper.displayMessage = false
        println(IngredientHelper.displayMessage)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfBarsInBarChartView(barChartView: JBBarChartView!) -> UInt {
        return 9
    }
    
    func barChartView(barChartView: JBBarChartView!, heightForBarViewAtIndex index: UInt) -> CGFloat {
        switch index{
        case 0:
            return CGFloat(tryp) //0.45 //0.15
        case 1:
            return CGFloat(thre) //1.81 //0.60
        case 2:
            return CGFloat(isol) //1.73 //0.58
        case 3:
            return CGFloat(leuc) //3.82 //1.27
        case 4:
            return CGFloat(lysi) //3.45 //1.15
        case 5:
            return CGFloat(meth) //1.73 //0.58
        case 6:
            return CGFloat(phen) //3.00 //1.00
        case 7:
            return CGFloat(vali) //2.18 //0.73
        case 8:
            return CGFloat(hist) //1.27 //0.42
        default:
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FoodCell", forIndexPath: indexPath) as! FoodTableViewCell //1
        cell.backgroundColor = UIColor.clearColor()
        let row = indexPath.row
        if row < IngredientHelper.ingredients.count{
            let tmpIngred = IngredientHelper.ingredients[row]
            let tmpMult = IngredientHelper.multipliers[row]
            cell.nameLabel?.text = "\(tmpMult)g \(tmpIngred.name)"
        }
        
        return cell
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        if let ingredientArr = IngredientHelper.ingredients{
            return Int(ingredientArr.count)
        }
        else{
            return 1
        }
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            IngredientHelper.ingredients.removeAtIndex(indexPath.row)
            IngredientHelper.multipliers.removeAtIndex(indexPath.row)
            aminoButton.hidden = true
            prepareBarChartView()
            prepareOtherViews()
            ingredientTable.reloadData()
            barChartView.reloadData()
        }
    }
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if(identifier == "showFood"){
            if IngredientHelper.ingredients.count == 0 || IngredientHelper.ingredients[0].name == "Add ingredients to see total protein!"{
                return false
            }
            else{
                return true
            }
        }
        else{
            return true
        }

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toSettings") {
            let settingsVc = SettingsViewController()
            //settingsVc.meat = displayMeat
        }
        if (segue.identifier == "showFood") {
            println("in showFood prepareForSegue")
            if IngredientHelper.ingredients[0].name == "Add ingredients to see total protein!"{
                IngredientHelper.ingredients.removeAtIndex(0)
                println("removed add ingred...")
            }

            
           if IngredientHelper.ingredients.count != 0{//"Add ingredients to see total protein!" {
                println("segue code getting run")
                let FoodViewController = segue.destinationViewController as! DisplayViewController
                var cell : UITableViewCell = sender as! UITableViewCell
                if self.ingredientTable?.indexPathForCell(cell) != nil {
                    let indexPath = self.ingredientTable?.indexPathForCell(cell)
                    selectedFood = IngredientHelper.ingredients[indexPath!.row]
                    FoodViewController.note = selectedFood
                    FoodViewController.multiplier = IngredientHelper.multipliers[indexPath!.row]
                }
           }
           else{
               println("count = 0")
           }
        }
    }
    
    @IBAction func deleteButtonPressed(sender:AnyObject){
        if IngredientHelper.ingredients.count > 0{
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveButtonPressed(sender:AnyObject){
        self.presentViewController(saveAlert, animated: true, completion: nil)
    }

    func saveConfirmed(){
        var recipe = RecipeWithPicture()
        recipe.title = textField.text
        for i in 0..<IngredientHelper.ingredients.count{
            recipe.ingredientStr = "\(recipe.ingredientStr)\n\(i+1). \(IngredientHelper.multipliers[i])g \(IngredientHelper.ingredients[i].name)"
            recipe.totProt = recipe.totProt + IngredientHelper.ingredients[i].protGram
        }
        println("new recipe!")
        
        realm.write() {
            self.realm.add(recipe, update: false)
        }
        if deleteSwitch.on{
            //if IngredientHelper.ingredients.count == 0{
            aminoButton.hidden = true
                aminoButton.enabled = false
            println("disabling button")
                prepareOtherViews()
            //}
            if IngredientHelper.ingredients.count > 0{
                for i in 0..<IngredientHelper.ingredients.count{
                    println("i: \(i)")
                    IngredientHelper.ingredients.removeAtIndex(0)
                }
                self.ingredientTable.reloadData()
                self.prepareOtherViews()
                self.barChartView.reloadData()
                
            }
        }
        if noPicture{
         //   self.presentViewController(saveMessage, animated: true, completion: nil)
        }
    }
    func configurationTextField(textField: UITextField!)
    {
        if let tField = textField {
            
            self.textField = textField!        //Save reference to the UITextField
            self.textField.text = "My Recipe"
        }
    }
    
    @IBAction func addFoodButtonPressed(sender:AnyObject){
        if IngredientHelper.ingredients.count > 0{
            if IngredientHelper.ingredients[0].name == "Add ingredients to see total protein!"{
                IngredientHelper.ingredients.removeAtIndex(0)
            }
        }
    }
    
    func prepareBarChartView(){
        barChartView.backgroundColor = myTransparentWhite
        barChartView.dataSource = self
        barChartView.delegate = self
        barChartView.minimumValue = 0
        barChartView.maximumValue = 4
        barChartView.reloadData()
    }
    
    func reloadRecipe(tmpRecipeStr: String){
        var recipes : [String] = split(tmpRecipeStr) {$0 == "\n"}
        println("string was split")
        for i in recipes{
            println(i)
        }
        for ingred in recipes{
            //ingred = String(dropFirst(dropFirst(dropFirst((ingred.characters))))
            var paredIngred = String(dropFirst(dropFirst(dropFirst(ingred))))
            println(paredIngred)
            var tmpMult : String = ""
            //var i = 0
            while(Array(paredIngred)[0] != "g"){
                println("paredIngred)[0]\(Array(paredIngred)[0])")
                tmpMult = "\(tmpMult)\(Array(paredIngred)[0])"
                paredIngred = String(dropFirst(paredIngred))
            }
            paredIngred = String(dropFirst(dropFirst(paredIngred)))
            println("paredIngred\(paredIngred)")
            mult = tmpMult.toInt()
            IngredientHelper.multipliers.append(mult)
            let namePredicate = NSPredicate(format: "name CONTAINS[c] %@", paredIngred)
            
            let tmpFood = realm.objects(FoodInfo).filter(namePredicate)
            println("\(object_getClassName(tmpFood))")
            IngredientHelper.ingredients.append(tmpFood[0])
        }
    }
    
    func addAlertAction(){
        alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                println("default")
                if IngredientHelper.ingredients.count > 0{
                    for i in 0..<IngredientHelper.ingredients.count{
                        IngredientHelper.ingredients.removeAtIndex(0)
                    }
                    self.aminoButton.hidden = true
                    self.ingredientTable.reloadData()
                    self.prepareOtherViews()
                    self.barChartView.reloadData()
                    
                }
                self.tmpIngredient = nil
            case .Cancel:
                println("cancel")
                
            case .Destructive:
                println("destructive")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .Default, handler: { action in
        }))
    }
    func addSaveAlertAction(){
        saveAlert.addAction(UIAlertAction(title: "Save without picture", style: .Default, handler: { action in
            self.noPicture = true
            switch action.style{
            case .Default:
                println("default")
                self.saveConfirmed()
            case .Cancel:
            println("cancel")
            
            case .Destructive:
            println("destructive")
            }
        }))
        

    let photoLibraryAction = UIAlertAction(title: "Save with picture", style: .Default) { (action) in
            self.noPicture = false
            self.saveConfirmed()
            self.photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
                let realm = Realm()
                if let image = image{
                    println("\(realm.objects(RecipeWithPicture)[realm.objects(RecipeWithPicture).count-1].ingredientStr)")
                    let add : NSData = UIImageJPEGRepresentation(image, 1)
                    println("converted image to NSData")
                    realm.write() {
                        self.realm.objects(RecipeWithPicture)[self.realm.objects(RecipeWithPicture).count-1].picture = add
                    }
                }

              //  self.presentViewController(self.saveMessage, animated: true, completion: nil)
            }
//            self.showImagePickerController(.PhotoLibrary)
//            self.presentViewController(self.saveMessage, animated: true, completion: nil)
        }
        
        saveAlert.addAction(photoLibraryAction)
        
        saveAlert.addAction(UIAlertAction(title: "No", style: .Default, handler: { action in
        }))
        
    }
//    func addSaveMessageAction(){
//        saveMessage.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
//            switch action.style{
//            case .Default:
//                println("default")
//            case .Cancel:
//                println("cancel")
//                
//            case .Destructive:
//                println("destructive")
//            }
//        }))
//    }
    func addAddFoodMessageAction(){
        addFoodMessage.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                println("default")
            case .Cancel:
                println("cancel")
                
            case .Destructive:
                println("destructive")
            }
        }))
    }
    func prepareOtherViews(){
        ingredientTable.dataSource = self
        ingredientTable.reloadData()

        if let totalProteinLabel = totalProteinLabel{
            totalProteinLabel.text = "Total protein: \(IngredientHelper.returnProteinTotal()) grams"
        }
        if let reportLabel = reportLabel{
            let (text,color) = IngredientHelper.returnLevelJudgement()
            (tryp,thre,isol,leuc,lysi,meth,phen,vali,hist) = IngredientHelper.returnAminoTotals()
            (good,aminoText,aminoColor) = IngredientHelper.returnAminoJudgement(tryp,thre:thre,isol:isol,leuc:leuc,lysi:lysi,meth:meth,phen:phen,vali:vali,hist:hist)
            reportLabel.text = "Progress: \(text)"
            reportLabel.textColor = color
            if(good == true){
                aminoLabel.text = "Excellent amino balance!"
            }
            else if(aminoText == "So-so balance"){
                aminoLabel.text = "Amino balance: \(aminoText)"
            }
            else{
                aminoLabel.text = "Amino balance: needs more\n "
                let (width, height) = widthHeight()
                aminoButton.setTitle(aminoText, forState: .Normal)
                aminoButton.setTitleColor(aminoColor, forState: .Normal)
                aminoButton.frame = CGRectMake(width/2 - 40, height - 30, 100, 50)
                aminoButton.addTarget(self, action: "pressedAction:", forControlEvents: .TouchUpInside)
                self.view.addSubview(aminoButton)
            }
            aminoLabel.textColor = aminoColor
        }
    }
    
    func pressedAction(sender: UIButton!) {
        // do your stuff here
        NSLog("you clicked on button %@", sender.tag)
        IngredientHelper.sortCat = IngredientHelper.mapAminoNames(aminoText)
        IngredientHelper.ascendDescend = false
        IngredientHelper.tmpCategory = ""
        println("IngredientHelper.sortCat\(IngredientHelper.sortCat)")
        self.performSegueWithIdentifier("seeAmino", sender: sender)
    }

    func barChartView(barChartView: JBBarChartView!, didSelectBarAtIndex index: UInt) {
            switch index{
            case 0:
                informationLabel.text = "Contains \(tryp)g Tryptophan"
            case 1:
                informationLabel.text = "Contains \(thre)g Threonine"
            case 2:
                informationLabel.text = "Contains \(isol)g Isoleucine"
            case 3:
                informationLabel.text = "Contains \(leuc)g Leucine"
            case 4:
                informationLabel.text = "Contains \(lysi)g Lysine"
            case 5:
                informationLabel.text = "Contains \(meth)g Methionine"
            case 6:
                informationLabel.text = "Contains \(phen)g Phenylalanine"
            case 7:
                informationLabel.text = "Contains \(vali)g Valine"
            case 8:
                informationLabel.text = "Contains \(hist)g Histidine"
            default:
                informationLabel.text = "Contains \(tryp)g DefaultCase!"
            }
    }
    func showImagePickerController(sourceType: UIImagePickerControllerSourceType) {
        imagePickerController = UIImagePickerController()
        imagePickerController!.sourceType = sourceType
        imagePickerController!.delegate = self
        self.presentViewController(imagePickerController!, animated: true, completion: nil)
    }
    func widthHeight() -> (CGFloat, CGFloat){
        var sizeRect = UIScreen.mainScreen().applicationFrame
        var width    = sizeRect.size.width
        var height   = sizeRect.size.height
        return (width, height)
    }
}
extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.dismissViewControllerAnimated(false, completion: nil)
        if let image = image{
            println("\(realm.objects(RecipeWithPicture)[realm.objects(RecipeWithPicture).count-1].ingredientStr)")
            let add : NSData = UIImageJPEGRepresentation(image, 1)
            println("converted image to NSData")
            realm.write() {
                self.realm.objects(RecipeWithPicture)[self.realm.objects(RecipeWithPicture).count-1].picture = add
            }
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}