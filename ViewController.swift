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
        pseudonymLabel.text = usersName + " the " + randomAdjective()
    }
    
    public func randomAdjective() -> String {
        var randomWord = ""
        
        if let path = Bundle.main.path(forResource: "adjectives", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let lines = data.components(separatedBy: .newlines)

                randomWord = lines[numericCast(arc4random_uniform(numericCast(lines.count)))]

            } catch {
                print(error)
            }
        }

        // Capitalizes first letter of each word
        return randomWord.prefix(1).uppercased() + randomWord.lowercased().dropFirst()
    }
    
    public func replaceLetters() {
        
        let transitionTable: [String : [String]] = [
            "a": ["a", "ae", "ai"],
            "b": ["b", "v"],
            "c": ["c", "k"],
            "e": ["ae", "e", "i"],
            "f": ["f", "ph"],
            "g": ["g", "j"],
            "j": ["j", "dg"],
            "q": ["q", "kyu"],
            "s": ["s", "es", "ss"],
            "t": ["t", "ti"],
            "u": ["u", "yu"],
            "v": ["v", "vi", "vee"],
            "y": ["y", "i", "ie"],
            "z": ["z", "zee", "zi", "zed"]
        ]
    
        for letterChar in usersName {
            let isLetterCapitalized: Bool = letterChar.isUppercase
            let letter = String(letterChar).lowercased()
            var randomReplacementLetter: String = letter
                
            if transitionTable[letter] != nil {
                let randomInt = Int.random(in: 0..<(transitionTable[letter]?.count ?? 1))
                randomReplacementLetter = transitionTable[letter]![randomInt]
            }
            
            if isLetterCapitalized {
                randomReplacementLetter = randomReplacementLetter.uppercased()
            }
            
            usersName = usersName.stringByReplacingFirstOccurrenceOfString(target: String(letterChar), withString: randomReplacementLetter)
        }
    }
    
    public func generateMagicianName() {
        replaceLetters()
        usersName += magicSuffix().lowercased()
        pseudonymLabel.text = usersName
    }
    
    public func magicSuffix() -> String {
        var randomWord = ""
        
        if let path = Bundle.main.path(forResource: "magicSuffixes", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let lines = data.components(separatedBy: .newlines)

                randomWord = lines[numericCast(arc4random_uniform(numericCast(lines.count)))]

            } catch {
                print(error)
            }
        }

        // Capitalizes first letter of each word
        return randomWord.prefix(1).uppercased() + randomWord.lowercased().dropFirst()
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
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

