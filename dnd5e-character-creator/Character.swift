//
//  Character.swift
//  dnd5e-character-creator
//
//  Created by Aaron Lam on 4/21/17.
//  Copyright © 2017 Aaron Lam. All rights reserved.
//

import Foundation



class Character {
    
    //utility
    var characterID: Int = 0
    var CharacterName: String?
    
    //class-race
    var Race: String?
    var Class: String?
    
    //stats
    var HitDice: String?
    var AC: Int = 0
    var HP: Int = 0
    var ProficiencyBonus: Int?
    var Speed: Int = 0
    var Initiative: Int?
    
    //abilities
    var Strength: Int = 0
    var Dexterity: Int = 0
    var Constitution: Int = 0
    var Intellegience: Int = 0
    var Wisdom: Int = 0
    var Charisma: Int = 0
    
    var StrengthMOD: Int = 0
    var DexterityMOD: Int = 0
    var ConstitutionMOD: Int = 0
    var IntellegienceMOD: Int = 0
    var WisdomMOD: Int = 0
    var CharismaMOD: Int = 0
    
    var RaceMOD = [Int]()
    
    //skills
    var Skills = [String]()
    var amountToChoose: Int?
    var SkillsChosen = [String]()
    
    //background
    var Alignment: String?
    var PersonalityTrait: String?
    var Ideals: String?
    var Bonds: String?
    var Flaw: String?
    var Background: String?
    
    //FUNCTIONS:
    func setStats(s: Int, d: Int, c: Int, i: Int, w: Int, ch: Int){
        Strength = s
        Dexterity = d
        Constitution = c
        Intellegience = i
        Wisdom = w
        Charisma = ch
    }
    
    func calculateModifiers(){
        var abilities = [Int]()
        var modifiers = [Int]()
        
        abilities.append(Strength)
        abilities.append(Dexterity)
        abilities.append(Constitution)
        abilities.append(Intellegience)
        abilities.append(Wisdom)
        abilities.append(Charisma)
        
        for i in abilities{
            if(i == 4 || i == 5){
                modifiers.append(-3)
            }
            else if(i == 6 || i == 7){
                modifiers.append(-2)
            }
            else if(i == 8 || i == 9){
                modifiers.append(-1)
            }
            else if(i == 10 || i == 11){
                modifiers.append(0)
            }
            else if(i == 12 || i == 13){
                modifiers.append(1)
            }
            else if(i == 14 || i == 5){
                modifiers.append(2)
            }
            else if(i == 16 || i == 17){
                modifiers.append(3)
            }
            else if(i == 18 || i == 19){
                modifiers.append(4)
            }
            else if(i == 20 || i == 21){
                modifiers.append(5)
            }
        }
        
        var count = 0
        for i in modifiers{
            if(count == 0){
                StrengthMOD = i
            }
            else if(count == 1){
                DexterityMOD = i
            }
            else if(count == 2){
                ConstitutionMOD = i
            }
            else if(count == 3){
                IntellegienceMOD = i
            }
            else if(count == 4){
                WisdomMOD = i
            }
            else{
                CharismaMOD = i
            }
            count += 1
        }
        
    }
    
    func calculateFinalAbilites(){
        
        var count = 0
        for i in RaceMOD{
            if(count == 0){
                Strength = Strength + i
            }
            else if(count == 1){
                Dexterity = Dexterity + i
            }
            else if(count == 2){
                Constitution = Constitution + i
            }
            else if(count == 3){
                Intellegience = Intellegience + i
            }
            else if(count == 4){
                Wisdom = Wisdom + i
            }
            else if(count == 5){
                Charisma = Charisma + i
            }
            count += 1
        }
        calculateModifiers()
        
    }
    
    func returnRaceMOD() -> Array<Int>{
        return RaceMOD
    }
    
    func setRace(myRace: String){
        Race = myRace
    }
    
    func setClass(myClass: String){
        Class = myClass
    }
    
    func setHitDie(myHitDie: String){
        HitDice = myHitDie
    }
    
    func calculateHP(){
        
        if(HitDice == "1d8"){
            HP = 8 + ConstitutionMOD
        }
        else if(HitDice == "1d10"){
            HP = 10 + ConstitutionMOD
        }
        else if(HitDice == "1d12"){
            HP = 12 + ConstitutionMOD
        }
        
    }
    
    func calculateInitiative() -> String{
        if(DexterityMOD >= 0){
            return "+" + String(DexterityMOD)
        }
        else{
            return String(DexterityMOD)
        }
    }
    
    func addSkills(newSkill: String){
        Skills.append(newSkill)
    }
    
    func returnSkills() -> Array<String>{
        return Skills
    }

    func setChooseAmount(amount: Int){
        amountToChoose = amount
    }
    
    func returnChooseAmount() -> Int{
        return amountToChoose!
    }
    
    func addChosenSkill(skill: String){
        if(SkillsChosen.count < amountToChoose!){
            SkillsChosen.append(skill)
        }
    }
    
    func returnSkillsChosen() -> Array<String>{
        return SkillsChosen
    }
    
    func returnChosenSkillAmount() -> Int{
        return SkillsChosen.count
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
}
