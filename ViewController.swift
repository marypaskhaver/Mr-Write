//
//  ViewController.swift
//  Pseudo Name
//
//  Created by Mary Paskhaver on 11/12/19.
//  Copyright © 2019 Nostaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var pseudonymLabel: UILabel!
    
    @IBAction func generateButtonPressed(_ sender: Any) {
        usersName = textBox.text ?? ""
        
        if (usersName == "") {
            pseudonymLabel.text = "Please type in your name!"
            return
        }
        
        var dropDownChoiceAndFunction: Dictionary = [String : () -> ()]()

        dropDownChoiceAndFunction =
                    ["Royal": generateRoyalName,
                     "Magician": generateMagicianName,
                     "Warrior": generateWarriorName]
        
        dropDownChoiceAndFunction[listItem]!()
    }
    
    
    var list = ["Royal", "Magician", "Warrior"]
    var dropDownChoiceAndFunction: Dictionary = [String : () -> ()]()
    var usersName: String!
    var listItem: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func generateRoyalName() {
        let rg = RoyalNameGenerator()
        pseudonymLabel.text = rg.generate(forName: usersName)
    }
    
    public func generateMagicianName() {
        let mg = MagicianNameGenerator()
        usersName = mg.generate(forName: usersName)
        pseudonymLabel.text = usersName
    }
    
    public func generateWarriorName() {
         pseudonymLabel.text = usersName + " the Bar"
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        self.view.endEditing(true)
        listItem = list[row]
        return list[row]
    }
    
}

extension String
{
    func stringByReplacingFirstOccurrenceOfString(
            target: String, withString replaceString: String) -> String
    {
        if let range = self.range(of: target) {
            return self.replacingCharacters(in: range, with: replaceString)
        }
        
        return self
    }
}

