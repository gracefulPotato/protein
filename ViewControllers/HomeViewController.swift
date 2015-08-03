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
import Haneke

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
    
    var selectedFood: FoodInfo?
    let realm = Realm()
    var textField = UITextField(frame: CGRectMake(0, 0, 10, 10))
    var imagePickerController: UIImagePickerController?
    var selectedImage : UIImage!
    let cache = Shared.dataCache
    var deleteSwitch : UISwitch = UISwitch(frame: CGRectMake(220, 40, 10, 10))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveAlert.addTextFieldWithConfigurationHandler(configurationTextField)
        saveAlert.view.addSubview(deleteSwitch)
        //println("is this loading the first time?")
        prepareBarChartView()
        if let tmpIngredient = tmpIngredient{
            println("adding ingredient")
            IngredientHelper.ingredients.append(tmpIngredient)
            prepareOtherViews()
        }
        else{
            println("in the else")
            let message = FoodInfo()
            message.name = "Add ingredients to see total protein!"
            IngredientHelper.ingredients.append(message)
            prepareOtherViews()
            ingredientTable.reloadData()
        }
        println("displayMeat: \(displayMeat)")
        addAlertAction()
        addSaveAlertAction()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // our code
        barChartView.reloadData()
        ingredientTable.reloadData()
        println("displayMeat: \(displayMeat)")
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
        
        let row = indexPath.row
        println("in cellforrowatindexpath, row = \(row)")
        if row < IngredientHelper.ingredients.count{
            let tmpIngred = IngredientHelper.ingredients[row]
            cell.nameLabel?.text = tmpIngred.name
            println(tmpIngred.name)
            println(cell.nameLabel?.text)
        }
        
        return cell
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        //return Int(allFoods.count)
        if let ingredientArr = IngredientHelper.ingredients{
            println(ingredientArr.count)
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
            println("indexPath.row: \(indexPath.row)")
            IngredientHelper.ingredients.removeAtIndex(indexPath.row)
            ingredientTable.reloadData()
            
//            let realm = Realm()
//            
//            realm.write() {
//                realm.delete(note)
//            }
            
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toSettings") {
            let settingsVc = SettingsViewController()
            settingsVc.meat = displayMeat
        }
        if (segue.identifier == "showFood") {
            if IngredientHelper.ingredients[0].name == "Add ingredients to see total protein!"{
                IngredientHelper.ingredients.removeAtIndex(0)
            }
            let FoodViewController = segue.destinationViewController as! DisplayViewController
            var cell : UITableViewCell = sender as! UITableViewCell
            if let indexPath = self.ingredientTable?.indexPathForCell(cell) {
                selectedFood = IngredientHelper.ingredients[indexPath.row]
            }
            FoodViewController.note = selectedFood
        }
    }
    
    @IBAction func deleteButtonPressed(sender:AnyObject){

        if IngredientHelper.ingredients.count > 0{
            self.presentViewController(alert, animated: true, completion: nil)
        }
        if(IngredientHelper.ingredients.count == 0){
            let message = FoodInfo()
            message.name = "Add ingredients to see total protein!"
            IngredientHelper.ingredients.append(message)
            ingredientTable.reloadData()
        }
    }
    @IBAction func saveButtonPressed(sender:AnyObject){
        //realm.transactionWithBlock() {
        //let deleteTheseObjs = toArray(Recipe.self) // tracks is of type [Track]
        //for i in 0..<deleteTheseObjs.count{
            //realm.deleteObject(deleteTheseObjs[i])
        //}
        //realm.deleteObject(Recipe.allObjects() as? RLMObject)
        //}
        //realm.deleteObject(withPredicate: realm.objects(Recipe))
        self.presentViewController(saveAlert, animated: true, completion: nil)
        //saveAlert.addTextFieldWithConfigurationHandler(configurationTextField)
        //var textField = saveAlert.textFieldAtIndex(0)
    }

    func saveConfirmed(){
        var recipe = RecipeWithPicture()
        recipe.title = textField.text
        for i in 0..<IngredientHelper.ingredients.count{
            println("in for loop, \(i) iteration")
            recipe.ingredientStr = "\(recipe.ingredientStr)\n\(i+1). \(IngredientHelper.ingredients[i].name)"
            recipe.totProt = recipe.totProt + IngredientHelper.ingredients[i].protGram
        }
        //recipe.img = selectedImage
        println("recipe.ingredientStr: \(recipe.ingredientStr)")
        println("recipe.totProt: \(recipe.totProt)")
        println("new recipe!")
        
        realm.write() {
            self.realm.add(recipe, update: false)
        }
        if deleteSwitch.on{
            if IngredientHelper.ingredients.count > 0{
                //self.presentViewController(self.alert, animated: true, completion: nil)
                for i in 0..<IngredientHelper.ingredients.count{
                    println("i: \(i)")
                    IngredientHelper.ingredients.removeAtIndex(0)
                }
                self.ingredientTable.reloadData()
                self.prepareOtherViews()
                self.barChartView.reloadData()
                
            }
        }
        println(realm.objects(RecipeWithPicture).count)
    }
    func configurationTextField(textField: UITextField!)
    {
        println("configurat hire the TextField")
        
        if let tField = textField {
            
            self.textField = textField!        //Save reference to the UITextField
            self.textField.text = "Hello world"
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
    func addAlertAction(){
        alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                println("default")
                if IngredientHelper.ingredients.count > 0{
                    //self.presentViewController(self.alert, animated: true, completion: nil)
                    for i in 0..<IngredientHelper.ingredients.count{
                        println("i: \(i)")
                        IngredientHelper.ingredients.removeAtIndex(0)
                    }
                    self.ingredientTable.reloadData()
                    self.prepareOtherViews()
                    self.barChartView.reloadData()
                    
                }
                self.tmpIngredient = nil
                //self.prepareOtherViews()
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
        // Only show camera option if rear camera is available
        if (UIImagePickerController.isCameraDeviceAvailable(.Rear)) {
            let cameraAction = UIAlertAction(title: "Photo from Camera", style: .Default) { (action) in
                self.saveConfirmed()
                self.showImagePickerController(.Camera)
            }
            
            saveAlert.addAction(cameraAction)
        }
        let photoLibraryAction = UIAlertAction(title: "Photo from Library", style: .Default) { (action) in
            self.saveConfirmed()
            self.showImagePickerController(.PhotoLibrary)
        }
        
        saveAlert.addAction(photoLibraryAction)
        
        saveAlert.addAction(UIAlertAction(title: "No", style: .Default, handler: { action in
        }))
    }
    func prepareOtherViews(){
        ingredientTable.dataSource = self //as UITableViewDataSource?
        ingredientTable.reloadData()

        if let totalProteinLabel = totalProteinLabel{
            totalProteinLabel.text = "Total protein: \(IngredientHelper.returnProteinTotal()) grams"
        }
        if let reportLabel = reportLabel{
            let (text,color) = IngredientHelper.returnLevelJudgement()
            (tryp,thre,isol,leuc,lysi,meth,phen,vali,hist) = IngredientHelper.returnAminoTotals()
            let (aminoText,aminoColor) = IngredientHelper.returnAminoJudgement(tryp,thre:thre,isol:isol,leuc:leuc,lysi:lysi,meth:meth,phen:phen,vali:vali,hist:hist)
            reportLabel.text = "Progress: \(text)"// amino balance __."
            reportLabel.textColor = color
            println(aminoText)
            aminoLabel.text = "Amino balance: \(aminoText)"
            aminoLabel.textColor = aminoColor
        }
    }
    func barChartView(barChartView: JBBarChartView!, didSelectBarAtIndex index: UInt) {
        //if let tryp = tryp, thre = thre, isol = isol, leuc = leuc, lysi = lysi, meth = meth, phen = phen, vali = vali, hist = hist{
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
        //}
    }
    func showImagePickerController(sourceType: UIImagePickerControllerSourceType) {
        imagePickerController = UIImagePickerController()
        imagePickerController!.sourceType = sourceType
        imagePickerController!.delegate = self
        self.presentViewController(imagePickerController!, animated: true, completion: nil)
    }
//    func takePhoto() {
//        // instantiate photo taking class, provide callback for when photo  is selected
//        photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!) { (image: UIImage?) in
//            // don't do anything, yet...
//        }
//    }
}
extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.dismissViewControllerAnimated(false, completion: nil)
        if let image = image{
            println(realm.objects(RecipeWithPicture).count)
            println("\(realm.objects(RecipeWithPicture)[realm.objects(RecipeWithPicture).count-1].ingredientStr)")
            println("about to convert and assign picture")
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