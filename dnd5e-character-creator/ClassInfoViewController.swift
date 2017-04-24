//
//  ClassInfoViewController.swift
//  dnd5e-character-creator
//
//  Created by Aaron Lam on 4/4/17.
//  Copyright © 2017 Aaron Lam. All rights reserved.
//

import UIKit

var totalSkills = 0

class ClassInfoViewController: UIViewController {
    
    
    var urlString = ""
    var urlString2 = ""
    
    @IBOutlet weak var classTextView: UITextView!
    
    //animate the opening of the popout window
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    //for animating on close of the popout window
    func removeAnimate(){
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        },
                       completion: {(finished : Bool) in
                        if(finished){
                            self.view.removeFromSuperview()
                        }
        })
    }
    
    //button to close the popout window
    @IBAction func closeButton(_ sender: Any) {
        
        self.removeAnimate()
        
    }
    
    
    func parseJson(){
        
        //print(sendClass)
        
        
        if(sendClass == "Barbarian"){
            urlString = "http://dnd5eapi.co/api/classes/1"
            DispatchQueue.main.async(execute: {
                self.classTextView.text.append("Class: Barbarian\n\n")
            })
        }
        if(sendClass == "Bard"){
            urlString = "http://dnd5eapi.co/api/classes/2"
            DispatchQueue.main.async(execute: {
                self.classTextView.text.append("Class: Bard\n\n")
            })
        }
        if(sendClass == "Druid"){
            urlString = "http://dnd5eapi.co/api/classes/4"
            DispatchQueue.main.async(execute: {
                self.classTextView.text.append("Class: Druid\n\n")
            })
        }
        if(sendClass == "Fighter"){
            urlString = "http://dnd5eapi.co/api/classes/5"
            DispatchQueue.main.async(execute: {
                self.classTextView.text.append("Class: Fighter\n\n")
            })
        }
        if(sendClass == "Rogue"){
            urlString = "http://dnd5eapi.co/api/classes/9"
            DispatchQueue.main.async(execute: {
                self.classTextView.text.append("Class: Rogue\n\n")
            })
        }
        
        
        var url = URL(string: urlString)
        
        //get the starting characteristics
        var task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print("ERROR")
            }
            else{
                if let content = data
                {
                    
                    do{
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        guard let hit_die = myJson["hit_die"] as? Int else{
                            return
                        }
                        
                        //sending things to main queue
                        DispatchQueue.main.async(execute: {
                            //self.classTextView.text.append("Class: " + name + "\n\n")
                            self.classTextView.text.append("Hit die: 1d" + String(hit_die) + "\n\n")
                            
                        })
                        
                        //SKILL PROFICIENCIES
                        //unwrapping a first level array from json
                        if let proficiency_choices = myJson["proficiency_choices"] as? [[String: Any]] {
                            for items in proficiency_choices {
                                //print(items["type"]!)
                                
                                let thing = items["type"]!
                                DispatchQueue.main.async(execute: {
                                    self.classTextView.text.append("Skill ")
                                    self.classTextView.text.append(thing as! String)
                                    self.classTextView.text.append(": \n\n")

                                })
                                
                                //second level 2D array access
                                if let from = items["from"] as? [[String: Any]] {
                                    for items in from {
                                        //print(items["type"]!)
                                        
                                        let thing = items["name"]!
                                        
                                        DispatchQueue.main.async(execute: {
                                            self.classTextView.text.append("\t")
                                            self.classTextView.text.append(thing as! String)
                                            self.classTextView.text.append("\n\n")
                                            //totalSkills += 1;
                                        })
                                        
                                    }
                                }
                            }
                        }
                        
                        
                        //ARMOR AND WEAPON
                        DispatchQueue.main.async(execute: {
                            self.classTextView.text.append("Weapon & Armor proficiencies:")
                            self.classTextView.text.append("\n\n")
                        })
                        
                        if let proficiency = myJson["proficiencies"] as? [[String: Any]] {
                            for items in proficiency {
                                //print(items["type"]!)
                                //second level 2D array access
                                let thing = items["name"]!
                                        
                                DispatchQueue.main.async(execute: {
                                    self.classTextView.text.append("\t")
                                    self.classTextView.text.append(thing as! String)
                                    self.classTextView.text.append("\n\n")
                                })
                            }
                        }
                        
                        
                        //SAVING THROWS
                        DispatchQueue.main.async(execute: {
                            self.classTextView.text.append("Saving throws:")
                            self.classTextView.text.append("\n\n")
                        })
                        if let savingthrow = myJson["saving_throws"] as? [[String: Any]] {
                            for items in savingthrow {
                                //print(items["type"]!)
                                //second level 2D array access
                                let thing = items["name"]!
                                
                                DispatchQueue.main.async(execute: {
                                    self.classTextView.text.append("\t")
                                    self.classTextView.text.append(thing as! String)
                                    self.classTextView.text.append("\n\n")
                                })
                            }
                        }
                    }
                    catch{
                        
                    }
                    
                }
            }
            
        }
        task.resume()
        
        
        //get starting equipment
        
        if(sendClass == "Barbarian"){
            urlString2 = "http://dnd5eapi.co/api/startingequipment/1"
        }
        if(sendClass == "Bard"){
            urlString2 = "http://dnd5eapi.co/api/startingequipment/2"
        }
        if(sendClass == "Druid"){
            urlString2 = "http://dnd5eapi.co/api/startingequipment/4"
        }
        if(sendClass == "Fighter"){
            urlString2 = "http://dnd5eapi.co/api/startingequipment/5"
        }
        if(sendClass == "Rogue"){
            urlString2 = "http://dnd5eapi.co/api/startingequipment/9"
        }
        
        url = URL(string: urlString2)
   
        task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print("ERROR")
            }
            else{
                if let content = data
                {
                    
                    do{
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        //sending things to main queue
                        DispatchQueue.main.async(execute: {
                            self.classTextView.text.append("Starting equipment:")
                            self.classTextView.text.append("\n\n")
                            
                        })
                        
                        //unwrapping a first level array from json
                        if let startingEquipment = myJson["starting_equipment"] as? [[String: Any]] {
                            for items in startingEquipment {
                                
                                //second level 2D array access
                                if let item = items["item"] as? [String: Any] {
                                    let name = item["name"]!
                                    DispatchQueue.main.async(execute: {
                                        self.classTextView.text.append("\t")
                                        self.classTextView.text.append(name as! String)
                                        self.classTextView.text.append("\n\n")
                                    })
                                    
                                }
                                let thing = items["quantity"]!
                                DispatchQueue.main.async(execute: {
                                    self.classTextView.text.append("\t\t")
                                    self.classTextView.text.append("Quantity: ")
                                    self.classTextView.text.append(String(thing as! Int))
                                    self.classTextView.text.append("\n\n")
                                })
                            }
                        }
                        
                    }
                    catch{
                        
                    }
                    
                }
            }
            
        }
        task.resume()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //show transparency
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        //animate on open
        self.showAnimate()
        
        //dont allow the text in the textview to be editable
        classTextView.isEditable = false

        totalSkills = 0
        
        //parse the json
        parseJson()
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
