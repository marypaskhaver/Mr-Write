//
//  TextFileReader.swift
//  Pseudo Name
//
//  Created by Mary Paskhaver on 11/28/19.
//  Copyright © 2019 Nostaw. All rights reserved.
//

import Foundation

class TextFileReader {
    func returnRandomWordFromFile(withName fileName: String) -> String {
        var randomWord = ""
        
        if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                
                // dropLast() needed to exclude blank line at end of txt file
                let lines = data.components(separatedBy: .newlines).dropLast()
                
                randomWord = lines[numericCast(arc4random_uniform(numericCast(lines.count)))]

            } catch {
                print(error)
            }
        }

        return randomWord
    }
}
