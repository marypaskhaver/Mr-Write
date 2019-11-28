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
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    
    var usersName: String!
    var usersGender: Int!
    var pickerListItem: String!
    var pickerChoiceAndFunction: [String : () -> ()]! = [ : ]
    var pickerList: [String] = []
    
    @IBAction func generateButtonPressed(_ sender: Any) {
        usersName = textBox.text ?? ""
        
        if (usersName == "") {
            pseudonymLabel.text = "Please type in your name!"
            return
        }
       
        pickerChoiceAndFunction[pickerListItem]!()
    }
    
    @IBAction func segmentedControlPressed(_ sender: Any) {
        // 0 is male, 1 is female
        usersGender = genderSegmentedControl.selectedSegmentIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerChoiceAndFunction = [
            "Royal": generateRoyalName,
            "Magician": generateMagicianName
        ]
        
        pickerList = Array(pickerChoiceAndFunction.keys)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func generateRoyalName() {
        let rg = RoyalNameGenerator()
        pseudonymLabel.text = rg.generate(forName: usersName, withGender: genderSegmentedControl.selectedSegmentIndex)
    }
    
    public func generateMagicianName() {
        let mg = MagicianNameGenerator()
        usersName = mg.generate(forName: usersName, withGender: genderSegmentedControl.selectedSegmentIndex)
        pseudonymLabel.text = usersName
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        pickerListItem = pickerList[row]
        return pickerList[row]
    }
    
}
