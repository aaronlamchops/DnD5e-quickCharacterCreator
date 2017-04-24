//
//  ViewController.swift
//  dnd5e-character-creator
//
//  Created by Aaron Lam on 3/28/17.
//  Copyright © 2017 Aaron Lam. All rights reserved.
//

import UIKit

var newCharacter = Character()

var allCharacters = [Character]()

//MAIN SCREEN VIEW CONTROLLER
class ViewController: UIViewController {

    
    @IBAction func nextButton(_ sender: Any) {
        
//        if let selectVC = storyboard?.instantiateViewController(withIdentifier: "SelectViewController"){
//            navigationController?.pushViewController(selectVC, animated: true)
//        }
        
        performSegue(withIdentifier: "RaceSegue", sender: self)
        
    }
    
    @IBAction func myCharactersButton(_ sender: Any) {
        
        if let myCharactersVC = storyboard?.instantiateViewController(withIdentifier: "MyCharactersViewController"){
            navigationController?.pushViewController(myCharactersVC, animated: true)
        }
        
    }
    
    @IBAction func unwindToMainMenu(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
