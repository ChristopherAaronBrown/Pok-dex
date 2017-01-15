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
    
    var name: String {
        return _name
    }
    
    var pokédexID: Int {
        return _pokédexID
    }
    
    init(name: String, pokédexID: Int) {
        self._name = name
        self._pokédexID = pokédexID
    }
}
