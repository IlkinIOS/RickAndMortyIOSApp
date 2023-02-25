//
//  RMCharacterCollectionViewCellViewModel.swift
//  RIckAndMorty
//
//  Created by Ilkin Murtuzayev on 12.02.23.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel: Hashable,Equatable {
   
    
  
           public let characterName:String
           private let characterStatus:RMCharacterStatus
           private let characterImageUrl:URL?
    
    
  
    
    
    init(
        characterName:String,
        characterStatus:RMCharacterStatus,
        characterImageUrl:URL?
        
    ) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    public var characterStatusText:String {
        return "Status: \(characterStatus.text)"
    }
    
    
   
    public func fetchImage(completion:@escaping (Result<Data, Error>)  -> Void) {
        
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        } 
        RMImageLoader.shared.downloadImage(url, completion: completion)
    
    }
    
    
    // MARK: - Hashable
    // You will learn it deepely
    
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
       func hash(into hasher: inout Hasher) {
           hasher.combine(characterName)
           hasher.combine(characterStatus)
           hasher.combine(characterImageUrl)
    }
    
    
    
}
