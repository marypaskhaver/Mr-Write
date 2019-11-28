//
//  RoyalNameGenerator.swift
//  Pseudo Name
//
//  Created by Mary Paskhaver on 11/27/19.
//  Copyright © 2019 Nostaw. All rights reserved.
//

import Foundation

class RoyalNameGenerator: NameGenerator {
    var textFileReader: TextFileReader = TextFileReader()
    
    public func generate(forName name: String) -> String {
        return name + " the " + adjective() + "\n" + title() + " of the " + noun()
    }
    
    private func title() -> String {
        return textFileReader.returnRandomWordFromFile(withName: "titles")
    }
    
    private func adjective() -> String {
        return textFileReader.returnRandomWordFromFile(withName: "adjectives")
    }
    
    private func noun() -> String {
       return textFileReader.returnRandomWordFromFile(withName: "nouns")
    }
    
}
