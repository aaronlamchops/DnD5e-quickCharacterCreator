//
//  FinalViewController.swift
//  dnd5e-character-creator
//
//  Created by Aaron Lam on 4/22/17.
//  Copyright © 2017 Aaron Lam. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {

    @IBOutlet weak var characterName: UITextField!
    @IBOutlet weak var raceLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var alignmentLabel: UILabel!
    
    @IBOutlet weak var profBonusLabel: UILabel!
    @IBOutlet weak var initBonusLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var HPLabel: UILabel!
    @IBOutlet weak var hitDiceLabel: UILabel!
    
    
    @IBOutlet weak var strStatLabel: UILabel!
    @IBOutlet weak var dexStatLabel: UILabel!
    @IBOutlet weak var conStatLabel: UILabel!
    @IBOutlet weak var intStatLabel: UILabel!
    @IBOutlet weak var wisStatLabel: UILabel!
    @IBOutlet weak var chrStatLabel: UILabel!
    
    
    @IBOutlet weak var strModLabel: UILabel!
    @IBOutlet weak var dexModLabel: UILabel!
    @IBOutlet weak var conModLabel: UILabel!
    @IBOutlet weak var intModLabel: UILabel!
    @IBOutlet weak var wisModLabel: UILabel!
    @IBOutlet weak var chrModLabel: UILabel!
    
    @IBOutlet weak var skillsChosenTextView: UITextView!
    
    
    @IBOutlet weak var personalityTextView: UITextView!
    @IBOutlet weak var idealsTextView: UITextView!
    @IBOutlet weak var bondTextView: UITextView!
    @IBOutlet weak var flawTextView: UITextView!
    

    @IBAction func saveButton(_ sender: Any) {
        newCharacter.CharacterName = characterName.text
        
        allCharacters.append(newCharacter)
        
        //create an id for the character just created
        allCharacters[allCharacters.count - 1].characterID = allCharacters.count
        
        var new = Character()
        
        newCharacter = new
        
        
        str = 0
        dex = 0
        con = 0
        int = 0
        wis = 0
        chr = 0
        
        
        //segue to the main menu
        performSegue(withIdentifier: "unwindToMainMenu", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        raceLabel.text = newCharacter.Race
        classLabel.text = newCharacter.Class
        backgroundLabel.text = newCharacter.Background
        alignmentLabel.text = newCharacter.Alignment
        
        profBonusLabel.text = "+2"
        initBonusLabel.text = newCharacter.calculateInitiative()
        speedLabel.text = String(newCharacter.Speed)
        
        newCharacter.calculateHP()
        HPLabel.text = String(newCharacter.HP)
        hitDiceLabel.text = newCharacter.HitDice
        
        
        strStatLabel.text = String(newCharacter.Strength)
        dexStatLabel.text = String(newCharacter.Dexterity)
        conStatLabel.text = String(newCharacter.Constitution)
        intStatLabel.text = String(newCharacter.Intellegience)
        wisStatLabel.text = String(newCharacter.Wisdom)
        chrStatLabel.text = String(newCharacter.Charisma)
        
        
        strModLabel.text = String(newCharacter.StrengthMOD)
        dexModLabel.text = String(newCharacter.DexterityMOD)
        conModLabel.text = String(newCharacter.ConstitutionMOD)
        intModLabel.text = String(newCharacter.IntellegienceMOD)
        wisModLabel.text = String(newCharacter.WisdomMOD)
        chrModLabel.text = String(newCharacter.CharismaMOD)
        
        
        //text views:
        for i in newCharacter.SkillsChosen{
            skillsChosenTextView.text.append(i + "\n")
        }
        
        
        
        personalityTextView.text = newCharacter.PersonalityTrait
        idealsTextView.text = newCharacter.Ideals
        bondTextView.text = newCharacter.Bonds
        flawTextView.text = newCharacter.Flaw
        
        
    }
    
    

}
