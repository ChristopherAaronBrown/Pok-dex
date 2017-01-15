//
//  PokédexCell.swift
//  Pokédex
//
//  Created by Chris Brown on 1/15/17.
//  Copyright © 2017 Chris Brown. All rights reserved.
//

import UIKit

class PokédexCell: UICollectionViewCell {
    
    @IBOutlet weak var pokémonImage: UIImageView!
    @IBOutlet weak var pokémonLabel: UILabel!
    
    var pokémon: Pokémon!
    
    func configureCell(pokémon: Pokémon) {
        self.pokémon = pokémon
        
        pokémonLabel.text = pokémon.name.capitalized
        pokémonImage.image = UIImage(named: "\(pokémon.pokédexID)")
    }
    
}
