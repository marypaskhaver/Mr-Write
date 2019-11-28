//
//  MagicianNameGenerator.swift
//  Pseudo Name
//
//  Created by Mary Paskhaver on 11/27/19.
//  Copyright © 2019 Nostaw. All rights reserved.
//

import Foundation

class MagicianNameGenerator: NameGenerator {
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
    
    public func generate(forName name: String) -> String {
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
        if (["a", "e", "i", "o", "u"].contains(name.last) && magicEnding.first == name.last!) {
            name = String(name.dropLast())
        }
        
        return name + magicEnding
    }
    
    private func magicSuffix() -> String {
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
    
    
}
