//
//  RMCharacterStatus.swift
//  RIckAndMorty
//
//  Created by Ilkin Murtuzayev on 28.01.23.
//

import Foundation
enum RMCharacterStatus:String,Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
}