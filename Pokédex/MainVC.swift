//
//  MainVC.swift
//  Pokédex
//
//  Created by Chris Brown on 1/14/17.
//  Copyright © 2017 Chris Brown. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var pokédexCollection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var musicButton: UIButton!
    
    var pokémon = [Pokémon]()
    var filteredPokémon = [Pokémon]()
    var musicPlayer: AVAudioPlayer!
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokédexCollection.delegate = self
        pokédexCollection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokémonCSV()
        initAudio()
    }
    
    func initAudio() {
        let audioPath = Bundle.main.url(forResource: "music", withExtension: "mp3")
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: audioPath!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            
            if UserDefaults.standard.bool(forKey: "playMusic") {
                musicPlayer.play()
                musicButton.alpha = 1.0
            } else {
                musicPlayer.pause()
                musicButton.alpha = 0.2
            }
            
        } catch let err as NSError {
            print("Trouble playing music. Error: \(err.debugDescription)")
        }
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
            
            let pokémon = isSearching ? filteredPokémon[indexPath.row] : self.pokémon[indexPath.row]
            
            cell.configureCell(pokémon: pokémon)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokémon = isSearching ? filteredPokémon[indexPath.row] : self.pokémon[indexPath.row]
        performSegue(withIdentifier: "PokémonDetailVC", sender: pokémon)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokémonDetailVC" {
            if let destination = segue.destination as? PokémonDetailVC {
                if let pokémon = sender as? Pokémon {
                    destination.pokémon = pokémon
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? filteredPokémon.count : pokémon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    @IBAction func musicPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            UserDefaults.standard.set(false, forKey: "playMusic")
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            UserDefaults.standard.set(true, forKey: "playMusic")
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
        } else {
            isSearching = true
            let searchBarEntry = searchBar.text!.lowercased()
            filteredPokémon = pokémon.filter({$0.name.range(of: searchBarEntry) != nil})
        }
        pokédexCollection.reloadData()
    }
    
}

