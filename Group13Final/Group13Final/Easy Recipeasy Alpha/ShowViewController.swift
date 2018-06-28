//
//  ShowViewController.swift
//  Easy Recipeasy Alpha
//
//  Created by Neha Sule on 4/13/17.
//  Copyright © 2017 Neha Sule. All rights reserved.
//

import UIKit
import CoreData


class ShowViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var enter: UITextField!
    @IBOutlet weak var enterLabel: UILabel!
    @IBOutlet weak var old: UILabel!
    
    var titleString: String!
    var users = [NSManagedObject]()
    
    var user: String!
    var pass: String!
    var email: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelTitle.text = "\((self.titleString)!) Page"
        self.enterLabel.text = "Enter New \((self.titleString)!)"
        
        if self.titleString == "Username"{
            self.old.text = "Current Username: \((user)!)"
        }
        if self.titleString == "Password"{
            self.old.text = "Current Password: \((pass)!)"
        }
        if self.titleString == "Email"{
            self.old.text = "Current Email: \((email)!)"
        }
        
        loadData()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: Any) {
        
        if self.labelTitle.text == "Username Page"{
            
            let newUser = enter.text
            var i = 0
            while i < users.count {
                let person = users[i].value(forKey: "logIn") as? String
                
                if (person!) == "true" {
                    users[i].setValue(newUser, forKey: "username")
                    break
                }
                else {
                    i = i + 1
                }
            }
        //print(users[i])
        }
        
        if self.labelTitle.text == "Password Page"{
            let newPass = enter.text
            var i = 0
            while i < users.count {
                let person = users[i].value(forKey: "logIn") as? String
                
                if (person!) == "true" {
                    users[i].setValue(newPass, forKey: "password")
                    break
                }
                else {
                    i = i + 1
                }
            }
        //print(users[i])
        }
        if self.labelTitle.text == "Email Page" {
            let newEmail = enter.text
            var i = 0
            while i < users.count {
                let person = users[i].value(forKey: "logIn") as? String
                
                if (person!) == "true" {
                    users[i].setValue(newEmail, forKey: "email")
                    break
                }
                else {
                    i = i + 1
                }
            }
        //print(users[i])
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContex = appDelegate.persistentContainer.viewContext
        do {
            // this was the problem ///////////////
            try managedContex.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Pressing return key will show keyboard
    func textFieldShouldReturn(enter textField: UITextField) -> Bool {
        enter.resignFirstResponder()
        return (true)
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
