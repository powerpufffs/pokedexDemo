//
//  File.swift
//  pokemon
//
//  Created by Z Tai on 11/25/18.
//  Copyright © 2018 Z Tai. All rights reserved.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
