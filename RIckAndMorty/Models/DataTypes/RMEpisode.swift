//
//  RMEpisode.swift
//  RIckAndMorty
//
//  Created by Ilkin Murtuzayev on 11.01.23.
//

import Foundation

struct RMEpisode:Codable {
    let id: Int
    let name: String
    let air_date:String
    let epiosde:String
    let characters:[String]
     
}



//{
//     "id": 1,
//     "name": "Pilot",
//     "air_date": "December 2, 2013",
//     "episode": "S01E01",
//     "characters": [
//       "https://rickandmortyapi.com/api/character/1",
//       "https://rickandmortyapi.com/api/character/2",
//       //...
//     ],
//     "url": "https://rickandmortyapi.com/api/episode/1",
//     "created": "2017-11-10T12:56:33.798Z"
//   }
