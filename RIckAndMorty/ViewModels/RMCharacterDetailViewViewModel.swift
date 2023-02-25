//
//  RMCharacterDetailViewViewModel.swift
//  RIckAndMorty
//
//  Created by Ilkin Murtuzayev on 19.02.23.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    
    private let character:RMCharacter
    
    
    init(character:RMCharacter ) {
        self.character = character
        
        
    }
     
    public var title:String {
        character.name.capitalized
    } 
    
}

 
