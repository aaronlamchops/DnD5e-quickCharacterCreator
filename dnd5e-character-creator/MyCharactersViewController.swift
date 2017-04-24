//
//  MyCharactersViewController.swift
//  dnd5e-character-creator
//
//  Created by Aaron Lam on 4/23/17.
//  Copyright © 2017 Aaron Lam. All rights reserved.
//

import UIKit

class MyCharactersViewController: UIViewController {

    @IBOutlet weak var myCharactersTableView: UITableView!
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "selectedCharacterSegue",
            let characterVC = segue.destination as? CharacterViewController {
            
            characterVC.selectcharacterName = allCharacters[selectedIndex].CharacterName!
            characterVC.selectraceLabel = allCharacters[selectedIndex].Race!
            characterVC.selectclassLabel = allCharacters[selectedIndex].Class!
            characterVC.selectbackgroundLabel = allCharacters[selectedIndex].Background!
            characterVC.selectalignmentLabel = allCharacters[selectedIndex].Alignment!
            characterVC.selectprofLabel = "+2"
            characterVC.selectinitLabel = String(allCharacters[selectedIndex].calculateInitiative())
            characterVC.selectspeedLabel = String(allCharacters[selectedIndex].Speed)
            characterVC.selecthpLabel = String(allCharacters[selectedIndex].HP)
            characterVC.selecthitDiceLabel = allCharacters[selectedIndex].HitDice!
            
            for i in allCharacters[selectedIndex].SkillsChosen{
                characterVC.selectskillsTextView.append(i + "\n")
            }
            
            characterVC.selectpersonality = allCharacters[selectedIndex].PersonalityTrait!
            characterVC.selectideal = allCharacters[selectedIndex].Ideals!
            characterVC.selectbond = allCharacters[selectedIndex].Bonds!
            characterVC.selectflaw = allCharacters[selectedIndex].Flaw!
            
            
            characterVC.selectstrStat = String(allCharacters[selectedIndex].Strength)
            characterVC.selectdexStat = String(allCharacters[selectedIndex].Dexterity)
            characterVC.selectconStat = String(allCharacters[selectedIndex].Constitution)
            characterVC.selectintStat = String(allCharacters[selectedIndex].Intellegience)
            characterVC.selectwisStat = String(allCharacters[selectedIndex].Wisdom)
            characterVC.selectchrStat = String(allCharacters[selectedIndex].Charisma)
            
            
            characterVC.selectstrMod = String(allCharacters[selectedIndex].StrengthMOD)
            characterVC.selectdexMod = String(allCharacters[selectedIndex].DexterityMOD)
            characterVC.selectconMod = String(allCharacters[selectedIndex].ConstitutionMOD)
            characterVC.selectintMod = String(allCharacters[selectedIndex].IntellegienceMOD)
            characterVC.selectwisMod = String(allCharacters[selectedIndex].WisdomMOD)
            characterVC.selectchrMod = String(allCharacters[selectedIndex].CharismaMOD)
            
        }
        
    }

}


extension MyCharactersViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.font = UIFont(name: "Nodesto Caps Condensed", size: 40)
        //cell.textLabel?.textAlignment = NSTextAlignment.center
        cell.textLabel?.text = allCharacters[indexPath.row].CharacterName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "selectedCharacterSegue", sender: self)
    }
    
}
