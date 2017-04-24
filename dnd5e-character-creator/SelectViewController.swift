//
//  SelectViewController.swift
//  dnd5e-character-creator
//
//  Created by Aaron Lam on 3/28/17.
//  Copyright © 2017 Aaron Lam. All rights reserved.
//

import UIKit

var sendRace = "";

class SelectViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var racePicker: UIPickerView!
    
    @IBOutlet weak var raceImage: UIImageView!
    
    @IBAction func moreInfoButton(_ sender: Any) {
        
        let moreInfoPopUp = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "racePopOut") as! MoreInfoRaceViewController
        self.addChildViewController(moreInfoPopUp)
        moreInfoPopUp.view.frame = self.view.frame
        self.view.addSubview(moreInfoPopUp.view)
        moreInfoPopUp.didMove(toParentViewController: self)
        
    }
    
    
    @IBAction func NextButton(_ sender: Any) {
        newCharacter.RaceMOD.removeAll()
        getRaceMOD(race: newCharacter.Race!)
        if let classVC = storyboard?.instantiateViewController(withIdentifier: "ClassViewController"){
            navigationController?.pushViewController(classVC, animated: true)
        }
    }
    
    //var races = ["Barbarian", "Bard", "Cleric", "Druid", "Fighter", "Monk", "Paladin", "Ranger", "Rogue", "Sorcerer", "Warlock", "Wizard"]
    
    var races = ["Dwarf", "Elf", "Halfling", "Human"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newCharacter.setRace(myRace: "Dwarf")
        newCharacter.RaceMOD.removeAll()
        getRaceMOD(race: "Dwarf")
        newCharacter.Speed = 30
        
    }
    
    //get the modifiers for the race
    func getRaceMOD(race: String){
        var urlString = ""
        
        if(race == "Dwarf"){
            urlString = "http://dnd5eapi.co/api/races/1"
        }
        if(race == "Elf"){
            urlString = "http://dnd5eapi.co/api/races/2"
        }
        if(race == "Halfling"){
            urlString = "http://dnd5eapi.co/api/races/3"
        }
        if(race == "Human"){
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
                        
                        if let abilityBonus = myJson["ability_bonuses"] as? [Any] {
                            for object in abilityBonus{
                                DispatchQueue.main.async(execute: {
                                    newCharacter.RaceMOD.append(object as! Int)
                                })
                            }
                        }
                        
                        guard let speedjson = myJson["speed"] as? Int else{
                            return
                        }
                        DispatchQueue.main.async(execute: {
                            newCharacter.Speed = speedjson
                        })
                        
                    }
                    catch{
                        
                    }
                    
                }
            }
            
        }
        task.resume()
    }

}

extension SelectViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return races.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        
        return races[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel
        
        if(pickerLabel == nil){
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Nodesto Caps Condensed", size: 24)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        
        pickerLabel?.text = races[row]
        
        pickerLabel?.textColor = UIColor.black
        
        raceImage.image = UIImage(named: races[row])
        
        sendRace = races[row]
        
        getRaceMOD(race: races[row])
        
        return pickerLabel!;
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        newCharacter.setRace(myRace: races[row])
        print(newCharacter.Race)
        getRaceMOD(race: races[row])
        
    }
    
}






