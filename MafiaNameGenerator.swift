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
        return String(name.dropLast()) + mafiaSuffix(forGender: gender) + " \"" + adjective().capitalized + " " + mafiaNouns().capitalized + "\"" 
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
