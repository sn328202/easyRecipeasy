//
//  PreferencesViewController.swift
//  Easy Recipeasy Alpha
//
//  Created by Neha Sule on 4/13/17.
//  Copyright © 2017 Neha Sule. All rights reserved.
//

import UIKit
import CoreData

class PreferencesViewController: UIViewController {
    
    var users = [NSManagedObject]()
    var alertController:UIAlertController? = nil
    var preferences: [String] = []


    @IBOutlet weak var titleString: UILabel!
    
    @IBOutlet weak var vegetarian: UISwitch!
    @IBOutlet weak var soy: UISwitch!
    @IBOutlet weak var gluten: UISwitch!
    @IBOutlet weak var peanut: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        titleString.text = "Dietary Preferences"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var i = 0
        
        while i <= users.count {
            
            let person = users[i].value(forKey: "logIn") as? String
            //print (person)
            
            if (person) == "true" {
                let v = (users[i].value(forKey: "vegetarian") as? String)!
                let s = (users[i].value(forKey: "soy") as? String)!
                let g = (users[i].value(forKey: "gluten") as? String)!
                let p = (users[i].value(forKey: "peanut") as? String)!
                
                preferences = []
                if g == "true"{
                    gluten.setOn(true, animated: true)
                }

                if p == "true"{
                    peanut.setOn(true, animated: true)
                }

                if s == "true"{
                    soy.setOn(true, animated: true)
                }

                if v == "true"{
                    vegetarian.setOn(true, animated: true)
                }
                
                break
            }
            else {
                i += 1
            }
        }

        viewDidLoad()
        
    }
    
    @IBAction func save(_ sender: Any) {
        
        var i = 0
        var preferences: [String] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        while i < users.count {
            
            let person = users[i].value(forKey: "logIn") as? String
            
            if (person) == "true" {
                
                if vegetarian.isOn{
                    users[i].setValue("true", forKey: "vegetarian")
                    preferences.append("Vegetarian")
                }
                if !(vegetarian.isOn){
                    users[i].setValue("false", forKey: "vegetarian")
                }
                
                if soy.isOn{
                    users[i].setValue("true", forKey: "soy")
                    preferences.append("Soy Allergy")
                }
                if !(soy.isOn){
                    users[i].setValue("false", forKey: "soy")
                }
                
                if gluten.isOn{
                    users[i].setValue("true", forKey: "gluten")
                    preferences.append("Gluten Allergy")
                }
                if !(gluten.isOn){
                    users[i].setValue("false", forKey: "gluten")
                }
                
                if peanut.isOn{
                    users[i].setValue("true", forKey: "peanut")
                    preferences.append("Peanut Allergy")
                }
                if !(peanut.isOn){
                    users[i].setValue("false", forKey: "peanut")
                }
                break

            }
            else {
                i = i + 1
            }
            
        }
        do {
            try managedContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        self.alertController = UIAlertController(title: "Dietary Preferences", message: "\(preferences.joined(separator: " "))", preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (
            action:UIAlertAction) in
            
        }
        self.alertController!.addAction(OKAction)
        
        self.present(self.alertController!, animated: true, completion:nil)
        
    }
    
    fileprivate func loadData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Users")
        
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        if let results = fetchedResults {
            users = results
        } else {
            print("Could not fetch")
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
