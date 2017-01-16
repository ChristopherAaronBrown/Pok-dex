//
//  PokémonDetailVC.swift
//  Pokédex
//
//  Created by Chris Brown on 1/15/17.
//  Copyright © 2017 Chris Brown. All rights reserved.
//

import UIKit

class PokémonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pokédexIDLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var hasNextEvoLabel: UILabel!
    
    var pokémon: Pokémon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokémon.downloadPokémonDetails {
            self.updateDetails()
        }
    }
    
    func updateDetails() {
        nameLabel.text = pokémon.name
        descriptionLabel.text = pokémon.description
        pokédexIDLabel.text = "\(pokémon.pokédexID)"
        typeLabel.text = pokémon.type
        heightLabel.text = pokémon.height
        weightLabel.text = pokémon.weight
        attackLabel.text = pokémon.attack
        defenseLabel.text = pokémon.defense
        mainImage.image = UIImage(named: "\(pokémon.pokédexID)")
        currentEvoImage.image = UIImage(named: "\(pokémon.pokédexID)")
        nextEvoImage.image = UIImage(named: "\(pokémon.nextEvoPokédexID)")
        hasNextEvoLabel.text = pokémon.nextEvoPokédexID == 0 ? "No Evolution" : "Next Evolution"
    }

    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
