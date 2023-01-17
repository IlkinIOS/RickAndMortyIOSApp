//
//  RMService.swift
//  RIckAndMorty
//
//  Created by Ilkin Murtuzayev on 13.01.23.
//

import Foundation

/// Primary API service object to get Rick and Morty data
final class RMService {
    
    /// Shared Singleton instance
     static let shared = RMService()
    
    /// Privatized Constructor
    private init() {
        
    }
    
    /// Send RIck and Morty API call
    /// - Parameters:
    ///   - request: Request Instance
    ///   - completion: Callback with data or error
    public func execute(_ request:RMRequest ,completion:@escaping() -> Void ) {
        
    }
}
  
