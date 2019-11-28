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
