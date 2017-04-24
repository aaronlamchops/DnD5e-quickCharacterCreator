//
//  AbilityScoresViewController.swift
//  dnd5e-character-creator
//
//  Created by Aaron Lam on 4/20/17.
//  Copyright © 2017 Aaron Lam. All rights reserved.
//

import UIKit

    var str = 0
    var dex = 0
    var con = 0
    var int = 0
    var wis = 0
    var chr = 0

class AbilityScoresViewController: UIViewController {

    @IBOutlet weak var randomStat1: UILabel!
    @IBOutlet weak var randomStat2: UILabel!
    @IBOutlet weak var randomStat3: UILabel!
    @IBOutlet weak var randomStat4: UILabel!
    @IBOutlet weak var randomStat5: UILabel!
    @IBOutlet weak var randomStat6: UILabel!
    
    @IBOutlet weak var strStat: UILabel!
    @IBOutlet weak var dexStat: UILabel!
    @IBOutlet weak var conStat: UILabel!
    @IBOutlet weak var intStat: UILabel!
    @IBOutlet weak var wisStat: UILabel!
    @IBOutlet weak var chrStat: UILabel!
    
    
    @IBOutlet weak var strStep: UIStepper!
    @IBAction func strStepper(_ sender: Any) {
        strStat.text = "\(Int(strStep.value))"
        str = Int(strStat.text!)!
    }
    
    
    @IBOutlet weak var dexStep: UIStepper!
    @IBAction func dexStepper(_ sender: Any) {
        dexStat.text = "\(Int(dexStep.value))"
        dex = Int(dexStat.text!)!
    }
    
    
    @IBOutlet weak var conStep: UIStepper!
    @IBAction func conStepper(_ sender: Any) {
        conStat.text = "\(Int(conStep.value))"
        con = Int(conStat.text!)!
    }
    
    
    @IBOutlet weak var intStep: UIStepper!
    @IBAction func intStepper(_ sender: Any) {
        intStat.text = "\(Int(intStep.value))"
        int = Int(intStat.text!)!
    }
    
    
    @IBOutlet weak var wisStep: UIStepper!
    @IBAction func wisStepper(_ sender: Any) {
        wisStat.text = "\(Int(wisStep.value))"
        wis = Int(wisStat.text!)!
    }
    
    
    @IBOutlet weak var chrStep: UIStepper!
    @IBAction func chrStepper(_ sender: Any) {
        chrStat.text = "\(Int(chrStep.value))"
        chr = Int(chrStat.text!)!
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
        newCharacter.setStats(s: str, d: dex, c: con, i: int, w: wis, ch: chr)
        newCharacter.calculateFinalAbilites()

        if let skillSelectVC = storyboard?.instantiateViewController(withIdentifier: "SkillSelectViewController"){
            navigationController?.pushViewController(skillSelectVC, animated: true)
        }
    }
    
    func statRoll() -> Int{
        
        var rolls = [Int]()
        
        var total = 0;
        
        for i in 1 ... 4 {
            rolls.append(Int(arc4random_uniform(6) + 1))
        }
        
        for i in 0 ... 3 {
            if(rolls[i] != rolls.min()){
                total += rolls[i]
            }
        }
        
        return total
    }
    
    
    func rollRandomScores(){
        
        while(str < 3 || dex < 3 || con < 3 || int < 3 || wis < 3 || chr < 3){
            str = statRoll()
            dex = statRoll()
            con = statRoll()
            int = statRoll()
            wis = statRoll()
            chr = statRoll()
        }
        
        
        randomStat1.text = String(str)
        randomStat2.text = String(dex)
        randomStat3.text = String(con)
        randomStat4.text = String(int)
        randomStat5.text = String(wis)
        randomStat6.text = String(chr)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newCharacter.setStats(s: 0, d: 0, c: 0, i: 0, w: 0, ch: 0)
        
        rollRandomScores()
        
        strStep.value = Double(str)
        dexStep.value = Double(dex)
        conStep.value = Double(con)
        intStep.value = Double(int)
        wisStep.value = Double(wis)
        chrStep.value = Double(chr)
        
        strStat.text = String(Int(strStep.value))
        dexStat.text = String(Int(dexStep.value))
        conStat.text = String(Int(conStep.value))
        intStat.text = String(Int(intStep.value))
        wisStat.text = String(Int(wisStep.value))
        chrStat.text = String(Int(chrStep.value))
        
        str = Int(strStat.text!)!
        dex = Int(dexStat.text!)!
        con = Int(conStat.text!)!
        int = Int(intStat.text!)!
        wis = Int(wisStat.text!)!
        chr = Int(chrStat.text!)!
        
        totalSkills = 0
        newCharacter.Skills.removeAll()
        getAmountSkills()
        //newCharacter.returnSkills()
    }

}



//gets the total amount of skills allowed to pick for the next screen
func getAmountSkills(){
    
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
                    
                    //SKILL PROFICIENCIES
                    //unwrapping a first level array from json
                    if let proficiency_choices = myJson["proficiency_choices"] as? [[String: Any]] {
                        for items in proficiency_choices {
                            
                            //second level 2D array access
                            if let from = items["from"] as? [[String: Any]] {
                                for items in from {
                                    //print(items["type"]!)
                                    
                                    let thing = items["name"]!
                                    
                                    DispatchQueue.main.async(execute: {
                                        newCharacter.addSkills(newSkill: thing as! String)
                                        totalSkills += 1;
                                    })
                                    
                                }
                            }
                            
                            let thing = items["choose"]!
                            DispatchQueue.main.async(execute: {
                                newCharacter.setChooseAmount(amount: thing as! Int)
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
