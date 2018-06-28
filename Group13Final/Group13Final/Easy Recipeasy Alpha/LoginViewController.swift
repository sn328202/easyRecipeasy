//
//  LoginViewController.swift
//  Easy Recipeasy Alpha
//
//  Created by Neha Sule on 3/22/17.
//  Copyright © 2017 Neha Sule. All rights reserved.
//

import UIKit
import CoreData


class LoginViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    var users = [NSManagedObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        createIngredientList()
        createRecipeList()
        createRevList()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func LogIn(_ sender: Any) {
        var i = 0
        while i < users.count {
            if users[i].value(forKey: "username") as? String != username.text || users[i].value(forKey: "password") as? String != password.text {
                users[i].setValue("false", forKey: "logIn")
                i = i + 1
            }
            else {
                performSegue(withIdentifier: "logIn", sender: nil)
                users[i].setValue("true" , forKey: "logIn")
                break
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Pressing return key will show keyboard
    func textFieldShouldReturn(username textField: UITextField) -> Bool {
        username.resignFirstResponder()
        return (true)
    }
    func textFieldShouldReturn(password textField: UITextField) -> Bool {
        password.resignFirstResponder()
        return (true)
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
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     if let navigationController = segue.destination as? UINavigationController {
     let vc = navigationController.topViewController as? HomeViewController
     //print(String(describing: Users.value(forKey: "name")!)
     vc?.name.text = String(describing: Users.value(forKey: "name")!)
     }
     }
     */
    
    
    
    
}
