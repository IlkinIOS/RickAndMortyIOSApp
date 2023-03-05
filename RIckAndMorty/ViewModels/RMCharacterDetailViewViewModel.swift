//
//  RMCharacterDetailViewViewModel.swift
//  RIckAndMorty
//
//  Created by Ilkin Murtuzayev on 19.02.23.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    
    
    
    enum SectionType: CaseIterable {
        case photo
        case information
        case episodes
    }
    
    public let sections = SectionType.allCases
    
    
    private let character:RMCharacter
    
    // MARK: - Init
    
    init(character:RMCharacter ) {
        self.character = character
    }
    

    private var requestUrl:URL? {
        return URL(string: character.url)
    }
    
    public var title:String {
        character.name.capitalized
    }
    
    
    
     
    
    
    
    
}
    
    


 
