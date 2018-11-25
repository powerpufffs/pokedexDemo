//
//  DetailViewController.swift
//  pokemon
//
//  Created by Z Tai on 11/24/18.
//  Copyright © 2018 Z Tai. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {
    var navBar = UINavigationBar()
    var name : String = ""
    var weight : Int = 0
    var height : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navbar = navigationController?.navigationBar else { return }
        view.addSubview(navBar)
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupLabels()
    }
    
    //Creates Labels and places in a stackview to be arragned vertically
    fileprivate func setupLabels() {
        let pokemon = IndividualPokemon(name: name, weight: weight, height: height)
        
        var nameLabel : UILabel {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.text = "Name: " + pokemon.name
            label.font = label.font.withSize(30)
            label.backgroundColor = UIColor.red.withAlphaComponent(0.3)
            return label
        }
        
        var weightLabel : UILabel {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.text = "Weight: \(pokemon.weight)"
            label.font = label.font.withSize(30)
            label.backgroundColor = UIColor.green.withAlphaComponent(0.3)
            return label
        }
        
        var heightLabel : UILabel {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.text = "Height: \(pokemon.height)"
            label.font = label.font.withSize(30)
            label.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
            return label
        }
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, weightLabel, heightLabel])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 130),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
            ])
    }
    
}
