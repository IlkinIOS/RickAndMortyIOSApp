//
//  RMCharacterViewController.swift
//  RIckAndMorty
//
//  Created by Ilkin Murtuzayev on 11.01.23.
//

import UIKit

/// Controller to look and search for characters 
final class RMCharacterViewController: UIViewController ,RMCharacterListViewDelegate{
 
    
    
    
    
    private let characterListView = RMCharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        view.addSubview(characterListView )
        characterListView.delegate = self
        
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor), characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor), characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        // Open detail controller for that character
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never 
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
}
 
