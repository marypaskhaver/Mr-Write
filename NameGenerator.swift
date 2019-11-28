//
//  NameGenerator.swift
//  Pseudo Name
//
//  Created by Mary Paskhaver on 11/27/19.
//  Copyright © 2019 Nostaw. All rights reserved.
//

import Foundation

protocol NameGenerator {
    var textFileReader: TextFileReader { get }
    func generate(forName name: String) -> String
}
