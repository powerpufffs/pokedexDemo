//
//  Pokemon.swift
//  pokemon
//
//  Created by Z Tai on 11/24/18.
//  Copyright © 2018 Z Tai. All rights reserved.
//

import Foundation

struct Pokedex: Decodable {
    let count: Int?
    let next: Bool?
    let previous: Bool?
    let results: [Results]
}

struct Results: Decodable {
    let name: String?
    let url: String?
}

struct Pokemon : Decodable {
    let height: Int?
    let id: Int?
    let name: String?
    let weight: Int?
}

struct IndividualPokemon {
    var name : String
    var weight : Int
    var height : Int
    
    init(name : String,
        weight : Int,
        height : Int) {
            self.name = name
            self.weight = weight
            self.height = height
        }
}

struct myStructWithInit {
    let myString: String?
    let myInt: Int?
    let myDouble: Double?
    
    init(myString: String? = nil, //👈
        myInt: Int? = nil,
        myDouble: Double? = nil) {
        
        self.myString = myString
        self.myInt = myInt
        self.myDouble = myDouble
    }
}


