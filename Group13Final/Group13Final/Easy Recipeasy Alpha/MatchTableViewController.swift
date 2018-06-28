//
//  MatchTableViewController.swift
//  Easy Recipeasy Alpha
//
//  Created by Neha Sule on 3/22/17.
//  Copyright © 2017 Neha Sule. All rights reserved.
//

import UIKit
import CoreData

class MatchTableViewController: UITableViewController {
    var recipeArray:Set<String> = []
    var alertController: UIAlertController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSevartionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipeArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var finalRecipes: [String] = Array(recipeArray)

        let cell = tableView.dequeueReusableCell(withIdentifier: "recipe", for: indexPath)
        
        cell.textLabel?.text = finalRecipes[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var finalRecipes: [String] = Array(recipeArray)
        
        self.alertController = UIAlertController(title: "Recipe", message: "\(finalRecipes[indexPath.row])", preferredStyle: UIAlertControllerStyle.alert)
        
        let recipe = UIAlertAction(title: "View Recipe", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            
            self.performSegue(withIdentifier: "show", sender: nil)
            
            print("Ok Button Pressed 1");
        }
        let review = UIAlertAction(title: "Check Reviews", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            
            /*let review = ReviewViewController(nibName: "ReviewViewController", bundle: nil)
             let navController = UINavigationController(rootViewController: review)
             self.present(navController, animated: true, completion: nil)*/
            
            self.performSegue(withIdentifier: "review", sender: nil)
            
            print("Ok Button Pressed 2");
        }
        
        self.alertController!.addAction(recipe)
        self.alertController!.addAction(review)
        self.present(self.alertController!, animated: true, completion:nil)
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var finalRecipes: [String] = Array(recipeArray)
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "show" {
            let nextScene = segue.destination as? RecipeDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            for a in rList {
                let b = a as? NSDictionary
                if (b?["Name"] as? String) == finalRecipes[(indexPath?.row)!] {
                    nextScene?.rdata = (b)!
                }
            }
            
        }
        
        if segue.identifier == "review" {
            let nextScene = segue.destination as? ReviewViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            for a in rList {
                let b = a as? NSDictionary
                if (b?["Name"] as? String) == finalRecipes[(indexPath?.row)!] {
                    nextScene?.rdata = (b)!
                }
            }
        }
    }
 

}
