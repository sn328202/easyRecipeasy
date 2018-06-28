//
//  AddReviewViewController.swift
//  Easy Recipeasy Alpha
//
//  Created by Thota Palivela on 4/12/17.
//  Copyright © 2017 Neha Sule. All rights reserved.
//

import UIKit

class AddReviewViewController: UIViewController {

    @IBOutlet weak var sliderNum: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderAction(_ sender: Any) {
        var currentValue = Int(slider.value)
        sliderNum.text = "\(currentValue)"
    }
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var reviewText: UITextView!
    
    var dictReview:Dictionary<String,String> = [:]
    var rdata:NSDictionary = [:]

    @IBAction func btnSubmit(_ sender: Any) {
        dictReview = ["Rating" : sliderNum.text!, "Recipe": rdata["Name"] as! String, "Review": reviewText.text!]
        revList = revList.adding(dictReview) as NSArray
        addReview()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        titlelbl.text = rdata["Name"] as! String
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
            
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Pressing return key will show keyboard
    func textFieldShouldReturn(reviewText textField: UITextField) -> Bool {
        reviewText.resignFirstResponder()
        return (true)
    }
    }




