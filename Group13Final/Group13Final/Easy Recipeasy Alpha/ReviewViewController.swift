//
//  ReviewViewController.swift
//  Easy Recipeasy Alpha
//
//  Created by Thota Palivela on 4/12/17.
//  Copyright © 2017 Neha Sule. All rights reserved.
//

import UIKit
import CoreData

class ReviewViewController: UIViewController {
    
    var recipe: NSManagedObject?
    var rdata:NSDictionary = [:]
    

    @IBOutlet weak var lblReview: UITextView!
    
    @IBOutlet weak var lblRecipe: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblRecipe.text = rdata["Name"] as? String
        var s:String = ""
        for r in revList {
            let x = r as! NSDictionary
            if x["Recipe"] as? String == lblRecipe.text {
                s = s + "Rating: " + (x["Rating"]! as! String) + "\n" + (x["Review"]! as! String) + "\n------\n"
            }
        }
        lblReview.text = s
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "add" {
            let nextScene = segue.destination as? AddReviewViewController
            let data = rdata
            nextScene?.rdata = data
        }
    }
    

}
