//
//  SettingsViewController.swift
//  Easy Recipeasy Alpha
//
//  Created by Neha Sule on 4/13/17.
//  Copyright © 2017 Neha Sule. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var overallCount: Int = 0
    var alertController:UIAlertController? = nil
    var preferences: [String] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fullName: UILabel!
    
    var users = [NSManagedObject]()
    var objects: NSMutableArray! = NSMutableArray()
    
    var loginInfo: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.objects.add("Username")
        self.objects.add("Password")
        self.objects.add("Email")
        
        self.tableView.reloadData()
        loadData()
    
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var i = 0
        
        while i <= users.count {
            
            let person = users[i].value(forKey: "logIn") as? String
            //print (person)
            
            if (person) == "true" {
                
                let username = (users[i].value(forKey: "username") as? String)!
                
                let password  = (users[i].value(forKey: "password") as? String)!
                
                let name = (users[i].value(forKey: "name") as? String)!
                
                let email = (users[i].value(forKey: "email") as? String)!
                
                preferences = []
                
                let g = (users[i].value(forKey: "gluten") as? String)!
                if g == "true"{
                    preferences.append("Gluten Free")
                }
                let p = (users[i].value(forKey: "peanut") as? String)!
                if p == "true"{
                    preferences.append("Peanut Allergy")
                }
                let s = (users[i].value(forKey: "soy") as? String)!
                if s == "true"{
                    preferences.append("Soy Allergy")
                }
                let v = (users[i].value(forKey: "vegetarian") as? String)!
                if v == "true"{
                    preferences.append("Vegetarian")
                }
                
                loginInfo = []
                loginInfo.append(username)
                loginInfo.append(password)
                loginInfo.append(name)
                loginInfo.append(email)
                
                overallCount = i
                
                break
            }
            else {
                i += 1
            }
        }
        
        //print(String(describing: users[i].value(forKey: "vegetarian")))
        //print(String(describing: users[i].value(forKey: "soy")))
        //print(String(describing: users[i].value(forKey: "gluten")))
        //print(String(describing: users[i].value(forKey: "peanut")))
        //print(users[i])
        
        self.fullName.text = String(loginInfo[2])
        
        tableView.reloadData()
    }
    
    func tableView (_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! TableViewCell
        
        cell.labelTitle.text = self.objects.object(at: indexPath.row) as? String
        
        if cell.labelTitle.text == "Username"{
            cell.detailTitle?.text = String(loginInfo[0])
        }
        if cell.labelTitle.text == "Password"{
            cell.detailTitle?.text = String(loginInfo[1])
        }
        if cell.labelTitle.text == "Email"{
            cell.detailTitle?.text = String(loginInfo[3])
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showView", sender: self)
    }
    
    @IBAction func diet(_ sender: Any) {
        
        self.performSegue(withIdentifier: "diet", sender: self)
        
    }
    
    @IBAction func viewDiet(_ sender: Any) {
        self.alertController = UIAlertController(title: "Dietary Preferences", message: "\(preferences.joined(separator: " "))", preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (
            action:UIAlertAction) in
            
        }
        self.alertController!.addAction(OKAction)
        
        self.present(self.alertController!, animated: true, completion:nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showView"{
            let upcoming: ShowViewController = segue.destination as! ShowViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            let titleString = self.objects.object(at: indexPath.row) as? String
            
            upcoming.user = String(describing: users[overallCount].value(forKey: "Username")!)
            upcoming.pass = String(describing: users[overallCount].value(forKey: "Password")!)
            upcoming.email = String(describing: users[overallCount].value(forKey: "Email")!)
            
            upcoming.titleString = titleString
            self.tableView.deselectRow(at: indexPath, animated: true)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
