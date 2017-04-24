//
//  MoreInfoRaceViewController.swift
//  dnd5e-character-creator
//
//  Created by Aaron Lam on 3/29/17.
//  Copyright © 2017 Aaron Lam. All rights reserved.
//

import UIKit

class MoreInfoRaceViewController: UIViewController {
    
    
    @IBOutlet weak var popUpScrollText: UITextView!

    @IBAction func closePopUpButton(_ sender: Any) {
        self.removeAnimate()
    }
    
    var passedData:String!
    
    var urlString = ""
    
    var name = ""
    var speed = 0
    var alignment = ""
    var age = ""
    var size = ""
    var size_description = ""
    
    
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
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
    
    
    
    func sendToTextView(){
        popUpScrollText.text.append("Race: " + name + "\n\n")
        popUpScrollText.text.append("Alignment: " + alignment + "\n\n")
        popUpScrollText.text.append("Speed: " + String(speed) + "\n\n")
        popUpScrollText.text.append("Age: " + age + "\n\n")
        popUpScrollText.text.append("Size: " + size + "\n\n")
        popUpScrollText.text.append("Size Description: " + size_description + "\n\n")
    }
    
    
    
    func parseJSON(){
        
        if(sendRace == "Dwarf"){
            urlString = "http://dnd5eapi.co/api/races/1"
        }
        if(sendRace == "Elf"){
            urlString = "http://dnd5eapi.co/api/races/2"
        }
        if(sendRace == "Halfling"){
            urlString = "http://dnd5eapi.co/api/races/3"
        }
        if(sendRace == "Human"){
            urlString = "http://dnd5eapi.co/api/races/4"
        }
        
        
        let url = URL(string: urlString)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print("ERROR")
            }
            else{
                if let content = data
                {
                    
                    do{
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        //print(myJson)
                        
//                        if let jsonDictionary = myJson["_id"] as? NSDictionary
//                        {
//                            print(jsonDictionary)
//                        }
                        
                        guard let namejson = myJson["name"] as? String else{
                            return
                        }
                        guard let alignmentjson = myJson["alignment"] as? String else{
                            return
                        }
                        guard let speedjson = myJson["speed"] as? Int else{
                            return
                        }
                        guard let agejson = myJson["age"] as? String else{
                            return
                        }
                        guard let sizejson = myJson["size"] as? String else{
                            return
                        }
                        guard let size_descjson = myJson["size_description"] as? String else{
                            return
                        }
                        guard let langjson = myJson["language_desc"] as? String else{
                            return
                        }
                        
                        DispatchQueue.main.async(execute: {
                            self.popUpScrollText.text.append("Race: " + namejson + "\n\n")
                            self.popUpScrollText.text.append("Age: " + agejson + "\n\n")
                            self.popUpScrollText.text.append("Alignment: " + alignmentjson + "\n\n")
                            self.popUpScrollText.text.append("Size: " + sizejson + "\n")
                            self.popUpScrollText.text.append("Description: " + size_descjson + "\n\n")
                            self.popUpScrollText.text.append("Speed: " + String(speedjson) + "\n\n")
                            self.popUpScrollText.text.append("Languages: " + langjson + "\n\n")
//                            for i in newCharacter.returnRaceMOD() {
//                                print(i)
//                            }
                        })
                        
                        DispatchQueue.main.async(execute: {
                            self.popUpScrollText.text.append("Ability Modifiers: \n\n")
                        })
                        if let abilityBonus = myJson["ability_bonuses"] as? [Any] {
                            var count = 0
                            for object in abilityBonus{
                                DispatchQueue.main.async(execute: {
                                    if(count == 0){
                                        self.popUpScrollText.text.append("\t" + "Str: +" + String(object as! Int) + "\n\n")
                                    }
                                    else if(count == 1){
                                        self.popUpScrollText.text.append("\t" + "Dex: +" + String(object as! Int) + "\n\n")
                                    }
                                    else if(count == 2){
                                        self.popUpScrollText.text.append("\t" + "Con: +" + String(object as! Int) + "\n\n")
                                    }
                                    else if(count == 3){
                                        self.popUpScrollText.text.append("\t" + "Int: +" + String(object as! Int) + "\n\n")
                                    }
                                    else if(count == 4){
                                        self.popUpScrollText.text.append("\t" + "Wis: +" + String(object as! Int) + "\n\n")
                                    }
                                    else{
                                        self.popUpScrollText.text.append("\t" + "Chr: +" + String(object as! Int) + "\n\n")
                                    }
                                    count += 1
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
        
        

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showAnimate()
        
        
        popUpScrollText.isEditable = false
        
        parseJSON()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

