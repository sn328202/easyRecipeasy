//
//  funcs.swift
//  Easy Recipeasy Alpha
//
//  Created by Ahsan Hussain on 4/17/17.
//  Copyright © 2017 Neha Sule. All rights reserved.
//

import Foundation
import Firebase
import CoreData

var iList:NSArray = []
var rList:NSArray = []
var revList:NSArray = []
let rootRef = FIRDatabase.database().reference()

func createIngredientList() {
    let ingredientRef = rootRef.child("INGREDIENTS")
    ingredientRef.observe(.value, with: { (snapshot) in
    let list = snapshot.value as! NSArray
    iList = list
    print(iList)
})
}

func createRecipeList() {
    let recipeRef = rootRef.child("RECIPES")
    recipeRef.observe(.value, with: { (snapshot) in
        let list = snapshot.value as! NSArray
        rList = list
        print(rList)
    })
}

func createRevList () {
    let revRef = rootRef.child("REVIEWS")
    revRef.observe(.value, with: { (snapshot) in
        let list = snapshot.value as! NSArray
        revList = list
        print(revList)
    })
}

func addIngredient() {
    let ingredientRef = rootRef.child("INGREDIENTS")
    ingredientRef.observe(.value, with: { (snapshot) in
        var list = snapshot.value as! NSArray
        list = iList
        ingredientRef.setValue(list)
    })
}

func addReview() {
    let revRef = rootRef.child("REVIEWS")
    revRef.observe(.value, with: { (snapshot) in
        var list = snapshot.value as! NSArray
        list = revList
        revRef.setValue(list)
    })
}

func getPrefrences() -> [String] {
    var users = [NSManagedObject]()
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
    
    var i = 0
    var prefrences:[String] = []
    while i <= users.count {
        
        let person = users[i].value(forKey: "logIn") as? String
        print (person)
        if (person) == "true" {
            let peanut = (users[i].value(forKey: "peanut") as? String)!
            
            let soy  = (users[i].value(forKey: "soy") as? String)!
            
            let gluten = (users[i].value(forKey: "gluten") as? String)!
            
            let vegetarian = (users[i].value(forKey: "vegetarian") as? String)!
            
            if peanut == "true" {
                prefrences.append("Peanut Allergy")
            }
            if soy == "true" {
                prefrences.append("Soy Allergy")
            }
            if gluten == "true" {
                prefrences.append("Gluten Free")
            }
            if vegetarian == "true" {
                prefrences.append("Vegetarian")
            }
            break
        }
        else{
            i = i + 1
        }
    }
    return prefrences
}


func addRecipe () {
    let recipeRef = rootRef.child("RECIPES")
    recipeRef.observe(.value, with: { (snapshot) in
        var list = snapshot.value as! NSArray
        list = rList
        recipeRef.setValue(list)
    })
}



