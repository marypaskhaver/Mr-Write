//
//  ViewController.swift
//  Pseudo Name
//
//  Created by Mary Paskhaver on 11/12/19.
//  Copyright © 2019 Nostaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, MyPickerViewProtocol {
    
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var interfacePickerView: UIPickerView!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var pseudonymLabel: UILabel!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    
    var usersName: String!
    var usersGender: Int!
    var pickerListItem: String!
    var pickerChoiceAndFunction: [String : () -> (String)]! = [ : ]
    var myPickerView: MyPickerView! // Custom class
    
    @IBAction func generateButtonPressed(_ sender: Any) {
        usersName = textBox.text ?? ""
        
        if (usersName == "") {
            pseudonymLabel.text = "Please type in your name!"
            return
        }
        
        pseudonymLabel.text = pickerChoiceAndFunction[pickerListItem]!()
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
            "Fantasy": generateFantasyName,
            "Mafia": generateMafiaName
        ]
        
        myPickerView = MyPickerView()
        myPickerView.pickerList = Array(pickerChoiceAndFunction.keys)
        
        interfacePickerView.delegate = myPickerView
        interfacePickerView.dataSource = myPickerView
        myPickerView.propertyThatReferencesThisViewController = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func generateRoyalName() -> String {
        return RoyalNameGenerator().generate(forName: usersName, withGender: genderSegmentedControl.selectedSegmentIndex)
    }
    
    public func generateFantasyName() -> String {
        return FantasyNameGenerator().generate(forName: usersName, withGender: genderSegmentedControl.selectedSegmentIndex)
    }
    
    public func generateMafiaName() -> String {
        return MafiaNameGenerator().generate(forName: usersName, withGender: genderSegmentedControl.selectedSegmentIndex)
    }
    
    func myPickerDidSelectRow(selectedRowValue: String) {
        pickerListItem = selectedRowValue
    }
    
}
