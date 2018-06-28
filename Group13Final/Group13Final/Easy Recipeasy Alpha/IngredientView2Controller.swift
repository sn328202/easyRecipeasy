//
//  IngredientView2Controller.swift
//  Easy Recipeasy Alpha
//
//  Created by Neha Sule on 5/6/17.
//  Copyright © 2017 Neha Sule. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class IngredientViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    var ingredients = [NSManagedObject]()
    var recipes = [NSManagedObject]()
    var RI:[[String:String]] = []
    var newName = ""
    
    let rootRef = FIRDatabase.database().reference()
    
    @IBOutlet weak var addNamelbl: UIButton!
    //var ingredients = [FoodItem]()
    var filteredIngredients = [NSManagedObject]()
    var alertController:UIAlertController? = nil
    //var contact:  IngredientViewController
    
    var selectedIngredients:Array = [String]()
    var selectedQuantities:Array = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func checkList(_ sender: Any) {
        self.alertController = UIAlertController(title: "Chosen Ingredients", message: "\(selectedIngredients.joined(separator: ", "))", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Clear List", style: UIAlertActionStyle.cancel) {
            (action:UIAlertAction) in self.selectedIngredients = []
        }
        self.alertController!.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (
            action:UIAlertAction) in
            
        }
        self.alertController!.addAction(OKAction)
        
        self.present(self.alertController!, animated: true, completion:nil)
    }
    
    
    override func viewDidLoad() {
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var search: UISearchBar!
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows:Int?
        if (tableView == self.searchDisplayController?.searchResultsTableView){
            rows = self.filteredIngredients.count
        }
        else{
            rows = iList.count
        }
        return rows!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        var ingredient : NSManagedObject
        
        if (tableView == self.searchDisplayController?.searchResultsTableView){
            
            ingredient = self.filteredIngredients[indexPath.row]
            cell.textLabel?.text = ingredient.value(forKey: "iname") as! String?
        }
        else{
            let x = iList[indexPath.row] as! NSDictionary
            cell.textLabel?.text = x["Name"] as! String
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        var ingredient:String?
        
        if tableView == self.searchDisplayController?.searchResultsTableView{
            
            //ingredient = self.filteredIngredients[indexPath.row]
        }
        else{
            let x = iList[indexPath.row] as! NSDictionary
            ingredient = x["Name"] as! String
            if !(selectedIngredients.contains(ingredient!)) {
                self.alertController = UIAlertController(title: "Add a Quantity for Ingredient", message: "Ingredient: \(ingredient!)" , preferredStyle: UIAlertControllerStyle.alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                    (action:UIAlertAction) in
                }
                self.alertController!.addAction(cancelAction)
                
                let OKAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.default) { (
                    action:UIAlertAction) in
                    if let field = self.alertController!.textFields![0] as? UITextField {
                        // store your data
                        self.selectedQuantities.append(field.text!)
                    } else {
                        // user did not fill field
                    }
                }
                self.alertController!.addAction(OKAction)
                self.alertController!.addTextField { (textField) in
                    textField.placeholder = "Quantity"
                }
                
                self.present(self.alertController!, animated: true, completion:nil)
            }
            
        }
        if !(selectedIngredients.contains(ingredient!)) {
            selectedIngredients.append(ingredient!)
        }
        
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "Title") {
        filteredIngredients = iList.filter { ingredient -> Bool in
            let categoryMatch = (scope == "Title")
            let s = ((ingredient as! NSDictionary)["Name"] as? String)?.lowercased().range(of: searchText)
            return categoryMatch && (s != nil)
            } as! [NSManagedObject]
        
        tableView.reloadData()
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearch searchString: String?) -> Bool{
        
        self.filterContentForSearchText(searchText: searchString!, scope: "Title")
        
        return true
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        
        self.filterContentForSearchText(searchText: (self.searchDisplayController?.searchBar.text)!, scope: "Title")
        
        return true
        
    }
    @IBAction func addIngredient(_ sender: Any) {
        self.alertController = UIAlertController(title: "Add an Ingredient", message: "Enter a single ingredient", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            (action:UIAlertAction) in
        }
        self.alertController!.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.default) { (
            action:UIAlertAction) in
            if let field = self.alertController!.textFields![0] as? UITextField {
                // store your data
                iList = iList.adding(["Name":field.text?.lowercased()]) as NSArray
                Easy_Recipeasy_Alpha.addIngredient()
                self.tableView.reloadData()
            } else {
                // user did not fill field
            }
        }
        self.alertController!.addAction(OKAction)
        self.alertController!.addTextField { (textField) in
            textField.placeholder = "Ingredient"
        }
        
        self.present(self.alertController!, animated: true, completion:nil)
    }
    
    @IBAction func addName(_ sender: Any) {
        self.alertController = UIAlertController(title: "Add a Name to Recipe", message: "Enter a name", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            (action:UIAlertAction) in
        }
        self.alertController!.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.default) { (
            action:UIAlertAction) in
            if let field = self.alertController!.textFields![0] as? UITextField {
                // store your data
                self.newName = field.text!
            } else {
                // user did not fill field
            }
        }
        self.alertController!.addAction(OKAction)
        self.alertController!.addTextField { (textField) in
            textField.placeholder = "Recipe Name"
        }
        
        self.present(self.alertController!, animated: true, completion:nil)
    }
    @IBAction func doneBtn(_ sender: Any) {
        if newName != ""{
            performSegue(withIdentifier: "upload", sender: nil)
        }
        else {
            addNamelbl.titleLabel?.font = UIFont(name: "optima-bold", size: 18)
        }
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "match"{
            var list:Set<String> = []
            let pref:[String] = getPrefrences()
            for r in rList {
                let x = r as! NSDictionary
                let rName = x["Name"] as! String
                let rIList = x["Ingredients"] as! NSArray
                if pref.isEmpty == true{
                    for s in selectedIngredients {
                        if rIList.contains(s) {
                            list.insert(rName)
                        }
                    }
                }
                else {
                    for s in selectedIngredients {
                        let d = x["Diet"] as! NSArray
                        for x in pref{
                            if d.contains(x) && rIList.contains(s) && x == pref.last! {
                                list.insert(rName)
                            }
                            else if d.contains(x) && rIList.contains(s){
                                continue
                            }
                            else {
                                break
                            }
                        }
                    }
                }
            }
            let nextScence = segue.destination as? MatchTableViewController
            nextScence?.recipeArray = list
        }
        
        
        if segue.identifier == "upload" {
            let nextScene = segue.destination as? UploadViewController
            nextScene?.Rname = newName
            nextScene?.Ilist = selectedIngredients
            nextScene?.Qlist = selectedQuantities
        }
    }
    
}
