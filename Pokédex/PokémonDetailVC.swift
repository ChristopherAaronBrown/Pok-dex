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
    @IBOutlet weak var currentEvoLVLLabel: UILabel!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var nextEvoLVLLabel: UILabel!
    
    var pokémon: Pokémon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokémon.name.capitalized
    }

    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
