//
//  MagicianNameGenerator.swift
//  Pseudo Name
//
//  Created by Mary Paskhaver on 11/27/19.
//  Copyright © 2019 Nostaw. All rights reserved.
//

import Foundation

class MagicianNameGenerator: NameGenerator {
    var textFileReader: TextFileReader = TextFileReader()
    
    private let transitionTable: [String : [String]] = [
        "a": ["a", "ae", "ai"],
        "b": ["b", "v"],
        "c": ["c", "k"],
        "e": ["e", "i"],
        "f": ["f", "ph"],
        "g": ["g", "j"],
        "j": ["j", "zh"],
        "q": ["q", "kyu"],
        "s": ["s", "es", "ss"],
        "t": ["t", "ti"],
        "u": ["u", "yu"],
        "v": ["v", "vi", "vee"],
        "y": ["y", "i", "ie"],
        "z": ["z", "zee", "zi", "zed"]
    ]
    
    public func generate(forName name: String, withGender gender: Int) -> String {
        // Allow name to be changed
        var name = name
        
        // Iterate through all the letters in the name
        for letterChar in name {
            let isLetterCapitalized: Bool = letterChar.isUppercase
            let letter = String(letterChar).lowercased()
            var randomReplacementLetter: String = letter
                
            if transitionTable[letter] != nil {
                var randomInt = Int.random(in: 0..<((transitionTable[letter]?.count)!))

                // It's more likely that the letters will be kept the same to avoid excessive changes
                if (randomInt <= (transitionTable[letter]?.count)! / 2 && name.count >= 5) {
                    randomInt = 0
                }
                
                randomReplacementLetter = transitionTable[letter]![randomInt]
            }
            
            // Maintain capitalization
            if isLetterCapitalized {
                randomReplacementLetter = randomReplacementLetter.uppercased()
            }
            
            name = name.stringByReplacingFirstOccurrenceOfString(target: String(letterChar), withString: randomReplacementLetter)
        }
        
        name = addMagicEnding(toName: name)
        
        return name
    }
    
    private func addMagicEnding(toName name: String) -> String {
        // Allow name to be changed
        var name = name
        
        let magicEnding: String = magicSuffix().lowercased()
        
        // Remove repeating vowels at the end of the user's name
        if (["a", "e", "i", "o", "u"].contains(name.last?.lowercased()) &&
            magicEnding.first?.lowercased() == name.last!.lowercased()) {
            name = String(name.dropLast())
        }
        
        return name + magicEnding
    }
    
    private func magicSuffix() -> String {
        return textFileReader.returnRandomWordFromFile(withName: "magicSuffixes")
    }
}

extension String {
    func stringByReplacingFirstOccurrenceOfString( target: String, withString replaceString: String) -> String {
        if let range = self.range(of: target) {
            return self.replacingCharacters(in: range, with: replaceString)
        }
        
        return self
    }
}
