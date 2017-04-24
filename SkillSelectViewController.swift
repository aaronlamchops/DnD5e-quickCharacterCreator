//
//  SkillSelectViewController.swift
//  dnd5e-character-creator
//
//  Created by Aaron Lam on 4/21/17.
//  Copyright © 2017 Aaron Lam. All rights reserved.
//

import UIKit

var switchValue = true;

class SkillSelectViewController: UIViewController {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var skillsTableView: UITableView!
    
    @IBAction func nextButton(_ sender: Any) {
        if let descriptionVC = storyboard?.instantiateViewController(withIdentifier: "DesciptionViewController"){
            navigationController?.pushViewController(descriptionVC, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the choose amount label
        amountLabel.text = String(newCharacter.returnChooseAmount())
        
        
        //register the custom cell that we created
        skillsTableView.register(UINib(nibName: "SkillCell", bundle: nil), forCellReuseIdentifier: "mySkillCell")
        skillsTableView.delegate = self
        skillsTableView.dataSource = self
        
        newCharacter.SkillsChosen.removeAll()
    }

    

}





extension SkillSelectViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalSkills
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = skillsTableView.dequeueReusableCell(withIdentifier: "mySkillCell") as! SkillCell
        cell.currentIndexPath = indexPath
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
    
    
}


