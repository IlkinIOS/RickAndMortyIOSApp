//
//  GetCharactersReponse.swift
//  RIckAndMorty
//
//  Created by Ilkin Murtuzayev on 08.02.23.
//

import Foundation

struct RMGetAllCharactersReponse: Codable {
    
    struct Info:Codable {
        let count:Int
        let pages:Int
        let next:String?
        let prev:String?

    }
    
    let info:Info
    let results:[RMCharacter]
    
}




