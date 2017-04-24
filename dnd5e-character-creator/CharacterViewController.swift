//
//  CharacterViewController.swift
//  dnd5e-character-creator
//
//  Created by Aaron Lam on 4/23/17.
//  Copyright © 2017 Aaron Lam. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {
    
    
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var raceLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var alignmentLabel: UILabel!
    @IBOutlet weak var profLabel: UILabel!
    @IBOutlet weak var initLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var hitDiceLabel: UILabel!
    
    @IBOutlet weak var skillsTextView: UITextView!
    @IBOutlet weak var personality: UITextView!
    @IBOutlet weak var ideal: UITextView!
    @IBOutlet weak var bond: UITextView!
    @IBOutlet weak var flaw: UITextView!
    
    
    @IBOutlet weak var strStat: UILabel!
    @IBOutlet weak var dexStat: UILabel!
    @IBOutlet weak var conStat: UILabel!
    @IBOutlet weak var intStat: UILabel!
    @IBOutlet weak var wisStat: UILabel!
    @IBOutlet weak var chrStat: UILabel!
    
    
    @IBOutlet weak var strMod: UILabel!
    @IBOutlet weak var dexMod: UILabel!
    @IBOutlet weak var conMod: UILabel!
    @IBOutlet weak var intMod: UILabel!
    @IBOutlet weak var wisMod: UILabel!
    @IBOutlet weak var chrMod: UILabel!
    
    
    
    
    
//     raceLabel
//     classLabel
//     backgroundLabel
//     alignmentLabel
//     profLabel
//     initLabel
//     speedLabel
//     hpLabel
//     hitDiceLabel
//    
//     skillsTextView
//     personality
//     ideal
//     bond
//     flaw
//    
//    
//     strStat
//     dexStat
//     conStat
//     intStat
//     wisStat
//     chrStat
//    
//    
//     strMod
//     dexMod
//     conMod
//     intMod
//     wisMod
//     chrMod
    
    
    var selectcharacterName = ""
    var selectraceLabel = ""
    var selectclassLabel = ""
    var selectbackgroundLabel = ""
    var selectalignmentLabel = ""
    var selectprofLabel = ""
    var selectinitLabel = ""
    var selectspeedLabel = ""
    var selecthpLabel = ""
    var selecthitDiceLabel = ""
    
    var selectskillsTextView = ""
    var selectpersonality = ""
    var selectideal = ""
    var selectbond = ""
    var selectflaw = ""
    
    
    var selectstrStat = ""
    var selectdexStat = ""
    var selectconStat = ""
    var selectintStat = ""
    var selectwisStat = ""
    var selectchrStat = ""
    
    
    var selectstrMod = ""
    var selectdexMod = ""
    var selectconMod = ""
    var selectintMod = ""
    var selectwisMod = ""
    var selectchrMod = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterName.text = selectcharacterName
        raceLabel.text = selectraceLabel
        classLabel.text = selectclassLabel
        backgroundLabel.text = selectbackgroundLabel
        alignmentLabel.text = selectalignmentLabel
        profLabel.text = selectprofLabel
        initLabel.text = selectinitLabel
        speedLabel.text = selectspeedLabel
        hpLabel.text = selecthpLabel
        hitDiceLabel.text = selecthitDiceLabel
        
        skillsTextView.text = selectskillsTextView
        personality.text = selectpersonality
        ideal.text = selectideal
        bond.text = selectbond
        flaw.text = selectflaw
        
        
        strStat.text = selectstrStat
        dexStat.text = selectdexStat
        conStat.text = selectconStat
        intStat.text = selectintStat
        wisStat.text = selectwisStat
        chrStat.text = selectchrStat
        
        
        strMod.text = selectstrMod
        dexMod.text = selectdexMod
        conMod.text = selectconMod
        intMod.text = selectintMod
        wisMod.text = selectwisMod
        chrMod.text = selectchrMod
        
        
        // Do any additional setup after loading the view.
    }

}
