//
//  RegisterViewController.swift
//  Easy Recipeasy Alpha
//
//  Created by Neha Sule on 3/22/17.
//  Copyright © 2017 Neha Sule. All rights reserved.
//

import UIKit
import CoreData


class RegisterViewController: UIViewController {
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var status: UILabel!
    
    var users = [NSManagedObject]()
    
    //Hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Pressing return key will show keyboard
    func textFieldShouldReturn(Name textField: UITextField) -> Bool {
        Name.resignFirstResponder()
        return (true)
    }
    func textFieldShouldReturn(Username: UITextField) -> Bool {
        Username.resignFirstResponder()
        return (true)
    }
    
    func textFieldShouldReturn(Password: UITextField) -> Bool {
        Password.resignFirstResponder()
        return (true)
    }

    func textFieldShouldReturn(Email: UITextField) -> Bool {
        Email.resignFirstResponder()
        return (true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SaveUser(_ sender: Any) {
        if Name.text == "" || Username.text == "" || Password.text == "" || Email.text == ""{
            status.text = "Account creation failed"
        }
        else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let managedContext = appDelegate.persistentContainer.viewContext
            // Create the entity we want to save
            let entity =  NSEntityDescription.entity(forEntityName: "Users", in: managedContext)
            
            let NewUser = NSManagedObject(entity: entity!, insertInto: managedContext)
            // Set the attribute values
            NewUser.setValue(Name.text, forKey: "name")
            NewUser.setValue(Username.text, forKey: "username")
            NewUser.setValue(Password.text, forKey: "password")
            NewUser.setValue(Email.text, forKey: "email")
            NewUser.setValue("false", forKey: "peanut")
            NewUser.setValue("false", forKey: "gluten")
            NewUser.setValue("false", forKey: "soy")
            NewUser.setValue("false", forKey: "vegetarian")
            // Commit the changes.
            do {
                try managedContext.save()
            } catch {
                // what to do if an error occurs?
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
            // Add the new entity to our array of managed objects
            users.append(NewUser)
            status.text = "Account creation successful"
        }
    }
}

