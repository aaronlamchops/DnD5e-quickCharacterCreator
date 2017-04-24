//
//  DesciptionViewController.swift
//  dnd5e-character-creator
//
//  Created by Aaron Lam on 4/22/17.
//  Copyright © 2017 Aaron Lam. All rights reserved.
//

import UIKit

class DesciptionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let alignmentTypes = ["Lawful Good", "Neutral Good", "Chaotic Good",
                          "Lawful Neutral", "True Neutral", "Chaotic Neutral",
                          "Lawful Evil", "Neutral Evil", "Chaotic Evil"]
    
    let backgroundTypes = ["Acolyte", "Charlatan", "Criminal", "Entertainer", "Folk Hero", "Guild Artisan", "Hermit", "Noble", "Outlander", "Sage", "Sailor", "Soldier", "Urchin"]
    
    
    @IBOutlet weak var alignmentPickerView: UIPickerView!
    @IBOutlet weak var backgroundPickerView: UIPickerView!
    
    @IBOutlet weak var personalityTrait: UITextView!
    @IBOutlet weak var ideals: UITextView!
    @IBOutlet weak var bond: UITextView!
    @IBOutlet weak var flaw: UITextView!

    
    @IBAction func nextButton(_ sender: Any) {
        
        newCharacter.PersonalityTrait = personalityTrait.text
        newCharacter.Ideals = ideals.text
        newCharacter.Bonds = bond.text
        newCharacter.Flaw = flaw.text
        
        if let finalVC = storyboard?.instantiateViewController(withIdentifier: "FinalViewController"){
            navigationController?.pushViewController(finalVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alignmentPickerView.delegate = self
        alignmentPickerView.dataSource = self
        backgroundPickerView.delegate = self
        backgroundPickerView.dataSource = self
        
        newCharacter.Alignment = "Lawful Good"
        newCharacter.Background = "Acolyte"
        newCharacter.PersonalityTrait = ""
        newCharacter.Ideals = ""
        newCharacter.Bonds = ""
        newCharacter.Flaw = ""
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == alignmentPickerView){
            return alignmentTypes.count
        }
        else if(pickerView == backgroundPickerView){
            return backgroundTypes.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == alignmentPickerView){
            return alignmentTypes[row]
        }
        else if(pickerView == backgroundPickerView){
            return backgroundTypes[row]
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == alignmentPickerView){
            newCharacter.Alignment = alignmentTypes[row]
            //print(newCharacter.Alignment!)
        }
        if(pickerView == backgroundPickerView){
            newCharacter.Background = backgroundTypes[row]
            //print(newCharacter.Background!)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel
        
        if(pickerLabel == nil){
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Nodesto Caps Condensed", size: 24)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        
        if(pickerView == alignmentPickerView){
            pickerLabel?.text = alignmentTypes[row]
        }
        else if(pickerView == backgroundPickerView){
            pickerLabel?.text = backgroundTypes[row]
        }
        
        pickerLabel?.textColor = UIColor.red
        
        return pickerLabel!
    }
    
}
