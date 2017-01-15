//
//  MainVC.swift
//  Pokédex
//
//  Created by Chris Brown on 1/14/17.
//  Copyright © 2017 Chris Brown. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var pokédexCollection: UICollectionView!
    
    var pokémon = [Pokémon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokédexCollection.delegate = self
        pokédexCollection.dataSource = self
        
        parsePokémonCSV()
    }

    func parsePokémonCSV() {
        let csvPath = Bundle.main.path(forResource: "pokémon", ofType: "csv")!
        
        do {
            let csv = try CSVParser(contentsOfURL: csvPath)
            let rows = csv.rows
            
            for row in rows {
                let name = row["identifier"]!
                let pokédexID = Int(row["id"]!)!
                let pokémon = Pokémon(name: name, pokédexID: pokédexID)
                self.pokémon.append(pokémon)
            }
            
        } catch let err as NSError {
            print("Unable to parse CSV file. Error: \(err.debugDescription)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokédexCell", for: indexPath) as? PokédexCell {
            
            let pokémon = self.pokémon[indexPath.row]
            
            cell.configureCell(pokémon: pokémon)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // PokédexCell tapped
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokémon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
}

