//
//  Pokémon.swift
//  Pokédex
//
//  Created by Chris Brown on 1/15/17.
//  Copyright © 2017 Chris Brown. All rights reserved.
//


class Pokémon {
    
    private var _name: String!
    private var _pokédexID: Int!
    private var _description: String!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _defense: String!
    private var _nextEvoLVL: String!
    
    var name: String {
        return _name
    }
    var pokédexID: Int {
        return _pokédexID
    }
    var desciption: String {
        return _description
    }
    var type: String {
        return _type
    }
    var height: String {
        return _height
    }
    var weight: String {
        return _weight
    }
    var attack: String {
        return _attack
    }
    var defense: String {
        return _defense
    }
    var nextEvoLVL: String {
        return _nextEvoLVL
    }
    
    init(name: String, pokédexID: Int) {
        self._name = name
        self._pokédexID = pokédexID
    }
}
