//
//  ClassViewController.swift
//  dnd5e-character-creator
//
//  Created by Aaron Lam on 4/4/17.
//  Copyright © 2017 Aaron Lam. All rights reserved.
//

import UIKit

var sendClass = "";

class ClassViewController: UIViewController {
    
    
//    var classes = ["Barbarian", "Bard", "Cleric", "Druid", "Fighter", "Paladin", "Ranger", "Rogue", "Wizard"]
    
    var classes = ["Barbarian", "Bard", "Druid", "Fighter", "Rogue"]
    

    @IBOutlet weak var classPicker: UIPickerView!
    
    @IBOutlet weak var classImage: UIImageView!
    
    @IBAction func moreInfoButton(_ sender: Any) {
        
        let classInfoPop = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "classPopOut") as! ClassInfoViewController
        self.addChildViewController(classInfoPop)
        classInfoPop.view.frame = self.view.frame
        self.view.addSubview(classInfoPop.view)
        classInfoPop.didMove(toParentViewController: self)
        
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
        getHitDice()
        
        if let abilityScoresVC = storyboard?.instantiateViewController(withIdentifier: "AbilityScoresViewController"){
            navigationController?.pushViewController(abilityScoresVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newCharacter.setClass(myClass: "Barbarian")
        newCharacter.HitDice = "1d12"
    }
}



func getHitDice(){
    
    var urlString = ""
    
    if(sendClass == "Barbarian"){
        urlString = "http://dnd5eapi.co/api/classes/1"
        
    }
    if(sendClass == "Bard"){
        urlString = "http://dnd5eapi.co/api/classes/2"
        
    }
    if(sendClass == "Druid"){
        urlString = "http://dnd5eapi.co/api/classes/4"
        
    }
    if(sendClass == "Fighter"){
        urlString = "http://dnd5eapi.co/api/classes/5"
        
    }
    if(sendClass == "Rogue"){
        urlString = "http://dnd5eapi.co/api/classes/9"
        
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
                        
                        newCharacter.HitDice = "1d" + String(hit_die)
                        
                    })
                    
                }
                catch{
                    
                }
                
            }
        }
        
    }
    task.resume()
}




extension ClassViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return classes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return classes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel
        
        if(pickerLabel == nil){
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Nodesto Caps Condensed", size: 24)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        
        pickerLabel?.text = classes[row]
        
        pickerLabel?.textColor = UIColor.black
        
        classImage.image = UIImage(named: classes[row])
        
        sendClass = classes[row]
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        newCharacter.setClass(myClass: classes[row])
        print(newCharacter.Class)
    }
}





