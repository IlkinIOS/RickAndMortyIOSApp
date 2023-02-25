//
//  RMCharacterDetailViewController.swift
//  RIckAndMorty
//
//  Created by Ilkin Murtuzayev on 19.02.23.
//

import UIKit


/// Controller to show info about singe character
 final class RMCharacterDetailViewController: UIViewController {
     
     
     
     private let viewModel: RMCharacterDetailViewViewModel
     
     init(viewModel:RMCharacterDetailViewViewModel) {
         self.viewModel = viewModel
         super.init(nibName: nil, bundle: nil)
         
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     
     
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
    
 
    
}
