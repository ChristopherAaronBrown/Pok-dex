//
//  Pokémon.swift
//  Pokédex
//
//  Created by Chris Brown on 1/15/17.
//  Copyright © 2017 Chris Brown. All rights reserved.
//

import Alamofire

class Pokémon {
    
    private var _name: String!
    private var _pokédexID: Int!
    private var _description: String!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _defense: String!
    private var _nextEvoPokédexID: Int!
    private var _nextEvoLVL: String!
    private var _apiURL: String!
    
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    var pokédexID: Int {
        if _pokédexID == nil {
            _pokédexID = 0
        }
        return _pokédexID
    }
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    var nextEvoPokédexID: Int {
        if _nextEvoPokédexID == nil {
            _nextEvoPokédexID = 0
        }
        return _nextEvoPokédexID
    }
    var nextEvoLVL: String {
        if _nextEvoLVL == nil {
            _nextEvoLVL = ""
        }
        return _nextEvoLVL
    }
    var apiURL: String {
        return _apiURL
    }
    
    init(name: String, pokédexID: Int) {
        self._name = name
        self._pokédexID = pokédexID
        self._apiURL = "\(URL_BASE)\(URL_POKÉMON)\(pokédexID)/"
    }
    
    func downloadPokémonDetails(completed: @escaping DownloadComplete) {
        Alamofire.request(apiURL).responseJSON { response in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let name = dict["name"] as? String {
                    self._name = name.capitalized
                }
                if let pkdx_id = dict["pkdx_id"] as? Int {
                    self._pokédexID = pkdx_id
                }
                if let descriptions = dict["descriptions"] as? [Dictionary<String, String>], descriptions.count > 0 {
                    if let resource_uri = descriptions[0]["resource_uri"] {
                        Alamofire.request("\(URL_BASE)\(resource_uri)").responseJSON { response in
                            if let descriptionDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = descriptionDict["description"] as? String {
                                    let fixedDescription = description.replacingOccurrences(of: "POKMON", with: "Pokémon")
                                    self._description = fixedDescription
                                }
                            }
                            completed()
                        }
                    }
                } else {
                    self._description = "No description"
                }
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    for i in 0..<types.count {
                        if let name = types[i]["name"], i == 0 {
                            self._type = "\(name.capitalized)"
                        } else if let name = types[i]["name"] {
                            self._type! += " | \(name.capitalized)"
                        }
                    }
                } else {
                    self._type = "No type"
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                    if let nextEvo = evolutions[0]["to"] as? String, nextEvo.range(of: "mega") == nil {
                        if let level = evolutions[0]["level"] as? Int {
                            self._nextEvoLVL = "\(level)"
                        }
                        if let resource_uri = evolutions[0]["resource_uri"] as? String {
                            Alamofire.request("\(URL_BASE)\(resource_uri)").responseJSON { response in
                                if let nextEvoDict = response.result.value as? Dictionary<String, AnyObject> {
                                    if let pkdx_id = nextEvoDict["pkdx_id"] as? Int {
                                        self._nextEvoPokédexID = pkdx_id
                                    }
                                }
                                completed()
                            }
                        }
                    }
                } else {
                    self._nextEvoLVL = ""
                    self._nextEvoPokédexID = 0
                }
                
            }
            
            completed()
        }
    }
}
