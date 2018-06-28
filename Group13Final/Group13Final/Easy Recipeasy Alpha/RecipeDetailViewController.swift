//
//  RecipeDetailViewController.swift
//  Easy Recipeasy Alpha
//
//  Created by Ahsan Hussain on 4/17/17.
//  Copyright © 2017 Neha Sule. All rights reserved.
//

import UIKit
import Social


class RecipeDetailViewController: UIViewController {
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var cookTimeLBL: UILabel!
    @IBOutlet weak var dietTypeLBL: UILabel!
    var rdata:NSDictionary = [:]

    @IBOutlet weak var IngredientsLBL: UITextView!
    @IBOutlet weak var StepsLBL: UITextView!
    
    var image = #imageLiteral(resourceName: "Easy ReciPeasy.png")
    

    @IBAction func share(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("I made \((rdata["Name"] as? String)!)! It only took \((rdata["Cook Time"] as? String)!). Thanks Easy Reci-Peasy!")
            facebookSheet.add(#imageLiteral(resourceName: "Easy ReciPeasy.png"))
            self.present(facebookSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TitleLbl.text = rdata["Name"] as? String
        cookTimeLBL.text = rdata["Cook Time"] as? String
        StepsLBL.text = rdata["Steps"] as? String
        
        var temp = rdata["Diet"] as? NSArray
        dietTypeLBL.text = temp?.componentsJoined(by: ", ")
        
        temp = rdata["Ingredients"] as? NSArray
        let temp2 = rdata["Quantity"] as? NSArray
        var s:String = ""
        for i in 0..<(temp?.count)! {
            let a = temp?[i] as? String
            let b = temp2?[i] as? String
            s = s + a! + " - " + b! + "\n"
        }
        IngredientsLBL.text = s
        
        
        /*
        let content: FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: self.contentURL)
        content.contentTitle = self.contentTitle
        content.contentDescription = self.contentDescription
        content.imageURL = NSURL(string: self.contentURLImage)
        FBSDKShareDialog.showFromViewController(self, withContent: content, delegate: nil)
        */
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
