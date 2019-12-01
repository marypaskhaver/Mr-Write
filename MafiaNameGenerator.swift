//
//  MafiaNameGenerator.swift
//  Pseudo Name
//
//  Created by Mary Paskhaver on 11/29/19.
//  Copyright © 2019 Nostaw. All rights reserved.
//

import Foundation

class MafiaNameGenerator: NameGenerator {
    var textFileReader: TextFileReader = TextFileReader()
    
    public func generate(forName name: String, withGender gender: Int) -> String {
        var theAdded: Bool = false
        
        var name = String(name.dropLast()).capitalized + mafiaSuffix(forGender: gender)
        
        if (Int.random(in: 0..<100) < 50) {
            name += " \"" + adjective().capitalized + " "
        } else {
            name += " the " + adjective().capitalized + " "
            theAdded = true
        }
                
        name += mafiaNouns().capitalized
        
        if !theAdded {
            name += "\""
        }
        
        return name
    }
    
    private func adjective() -> String {
        return textFileReader.returnRandomWordFromFile(withName: "adjectives")
    }
    
    private func mafiaSuffix(forGender gender: Int) -> String {
        if gender == 0 {
            return textFileReader.returnRandomWordFromFile(withName: "maleMafiaSuffixes")
        }
        
        return textFileReader.returnRandomWordFromFile(withName: "femaleMafiaSuffixes")
    }
    
    private func mafiaNouns() -> String {
       return textFileReader.returnRandomWordFromFile(withName: "mafiaNouns")
    }
}
