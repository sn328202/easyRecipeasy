//
//  UploadViewController.swift
//  Easy Recipeasy Alpha
//
//  Created by Neha Sule on 5/6/17.
//  Copyright © 2017 Neha Sule. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController {
    var Rname = ""
    var Ilist:Array = [String]()
    var Qlist:Array = [String]()
    var Dlist:Array = [String]()
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var ingredientsLbl: UITextView!
    @IBOutlet weak var stepsField: UITextView!
    @IBOutlet weak var cookTimeLbl: UITextField!
    
    @IBOutlet weak var vegLBL: UIButton!
    @IBOutlet weak var soyLBL: UIButton!
    @IBOutlet weak var gfLBL: UIButton!
    @IBOutlet weak var peanutLBL: UIButton!
    @IBOutlet weak var dietLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = Rname
        dietLbl.text = Dlist.joined(separator: ",")
        
        var s:String = ""
        for i in 0..<(Ilist.count) {
            let a = Ilist[i]
            let b = Qlist[i]
            s = s + a + " - " + b + "\n"
        }
        ingredientsLbl.text = s
        //stepsField.placeholder = "Enter Steps"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func vegBTN(_ sender: Any) {
        if !(Dlist.contains((vegLBL.titleLabel?.text)!)) {
            Dlist.append((vegLBL.titleLabel?.text)!)
            updateDietBTN()
        }
        else {
            Dlist.remove(at: Dlist.index(of: (vegLBL.titleLabel?.text)!)!)
            updateDietBTN()
        }
        vegLBL.titleLabel?.textColor = UIColor.white
        
    }
    @IBAction func soyBTN(_ sender: Any) {
        if !(Dlist.contains((soyLBL.titleLabel?.text)!)) {
            Dlist.append((soyLBL.titleLabel?.text)!)
            updateDietBTN()
        }
        else {
            Dlist.remove(at: Dlist.index(of: (soyLBL.titleLabel?.text)!)!)
            updateDietBTN()
        }
        soyLBL.titleLabel?.textColor = UIColor.white
    }
    @IBAction func gfBTN(_ sender: Any) {
        if !(Dlist.contains((gfLBL.titleLabel?.text)!)) {
            Dlist.append((gfLBL.titleLabel?.text)!)
            updateDietBTN()
        }
        else {
            Dlist.remove(at: Dlist.index(of: (gfLBL.titleLabel?.text)!)!)
            updateDietBTN()
        }
        gfLBL.titleLabel?.textColor = UIColor.white
    }
    @IBAction func peanutBTN(_ sender: Any) {
        if !(Dlist.contains((peanutLBL.titleLabel?.text)!)) {
            Dlist.append((peanutLBL.titleLabel?.text)!)
            updateDietBTN()
        }
        else {
            Dlist.remove(at: Dlist.index(of: (peanutLBL.titleLabel?.text)!)!)
            updateDietBTN()
        }
        peanutLBL.titleLabel?.textColor = UIColor.white
    }
    
    @IBAction func uploadBTN(_ sender: Any) {
        var dict:[String:Any] = [:]
        dict = ["Name" : Rname, "Cook Time" : cookTimeLbl.text!, "Steps" : stepsField.text, "Ingredients" : Ilist, "Quantity": Qlist, "Diet":Dlist] as [String:Any]
        print(dict)
        if cookTimeLbl.text! != "" && stepsField.text != "" {
            rList = rList.adding(dict) as NSArray
            Easy_Recipeasy_Alpha.addRecipe()
        }
    }
    func updateDietBTN() {
        let s = Dlist.joined(separator: " ")
        dietLbl.text = s
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
