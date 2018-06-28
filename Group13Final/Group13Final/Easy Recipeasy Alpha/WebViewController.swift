//
//  WebViewController.swift
//  Easy Recipeasy Alpha
//
//  Created by Neha Sule on 5/6/17.
//  Copyright © 2017 Neha Sule. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBAction func giada(_ sender: Any) {
        
        let urlGiada = URL(string: "http://www.giadadelaurentiis.com")
        UIApplication.shared.open(urlGiada!, options: [:], completionHandler: nil)
    }
    @IBAction func ramsay(_ sender: Any) {
        
        let urlRamsay = URL(string: "https://www.gordonramsay.com")
        UIApplication.shared.open(urlRamsay!, options: [:], completionHandler: nil)
    }
    
    @IBAction func batali(_ sender: Any) {
        
        let urlBatali = URL(string: "http://www.mariobatali.com")
        UIApplication.shared.open(urlBatali!, options: [:], completionHandler: nil)
    }
    
    @IBAction func puck(_ sender: Any) {
        
        let urlPuck = URL(string: "https://wolfgangpuck.com")
        UIApplication.shared.open(urlPuck!, options: [:], completionHandler: nil)
    }
    
    @IBAction func ray(_ sender: Any) {
        
        let urlRay = URL(string: "http://www.rachaelray.com")
        UIApplication.shared.open(urlRay!, options: [:], completionHandler: nil)
    }
    
    @IBAction func flay(_ sender: Any) {
        
        let urlFlay = URL(string: "http://bobbyflay.com")
        UIApplication.shared.open(urlFlay!, options: [:], completionHandler: nil)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
