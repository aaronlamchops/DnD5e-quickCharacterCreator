//
//  SkillCell.swift
//  dnd5e-character-creator
//
//  Created by Aaron Lam on 4/21/17.
//  Copyright © 2017 Aaron Lam. All rights reserved.
//

import UIKit

class SkillCell: UITableViewCell {
    
    
    
    @IBOutlet weak var skillLabel: UILabel!

    @IBOutlet weak var skillSwitch: UISwitch!


    @IBAction func switchChanged(_ sender: UISwitch) {
        
        if (skillSwitch.isOn == true && newCharacter.returnChosenSkillAmount() < newCharacter.returnChooseAmount()){
            newCharacter.addChosenSkill(skill: skillLabel.text!)
            for i in newCharacter.returnSkillsChosen(){
                print(i)
            }
            print("--END--")
        }
        else{
            skillSwitch.isOn = false
            for i in newCharacter.SkillsChosen{
                if(i == skillLabel.text){
                    newCharacter.SkillsChosen.remove(at: newCharacter.SkillsChosen.index(of: skillLabel.text!)!)
                }
            }
        }
        
    }
    
    
    var currentIndexPath: IndexPath? {
        didSet {
            setSkillLabel()
        }
    }
    
    
    func setSkillLabel(){
        if let currentSection = currentIndexPath?.section,
            let currentRow = currentIndexPath?.row{
            skillLabel.text = newCharacter.Skills[currentRow]
            
            skillSwitch.isOn = false
        }

    }
    
}
