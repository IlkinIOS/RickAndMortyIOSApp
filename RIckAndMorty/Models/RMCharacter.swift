//
//  RMCharacter.swift
//  RIckAndMorty
//
//  Created by Ilkin Murtuzayev on 11.01.23.
//

import Foundation


struct RMCharacter:Codable {
    let id:Int
    let name:String
    let status:String
    let species: String
    let type: String
    let gender:RMCharacterGender
    let origin:RMOrigin
    let location:RMSingleLocation
    let image:String
    let episode:[String]
    let url:String
    let created:String
    
}




