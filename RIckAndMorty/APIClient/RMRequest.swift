//
//  RMRequest.swift
//  RIckAndMorty
//
//  Created by Ilkin Murtuzayev on 13.01.23.
//

import Foundation

/// Object that represents a single API call
final class RMRequest {
    
    
    
    //QueryParameters
    
    
    private struct Constants {
        static let baseURl = "https://rickandmortyapi.com/api"
    }
    
    private let endpoint:RMEndpoint
    
    private let pathComponents: [String]
    
    private let queryParameters:[URLQueryItem]
    
    ///Constructed url for the api request in string format
    private var urlString:String {
        var string = Constants.baseURl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            
            pathComponents.forEach({
                string += "/\($0 )"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap ({
                guard let value = $0.value else {return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
            
        }
        
        return string
    }
    
    public var url:URL? {
        return URL(string: urlString)
    }
    
    
    
    public let httpMethod = "GET"
    
    init(endpoint: RMEndpoint,
         pathComponents: [String] = [] ,
         queryParameters:[URLQueryItem] = [] ) {
        self.endpoint = endpoint
        self.queryParameters = queryParameters
        self.pathComponents = pathComponents
    }
    
    // https://rickandmortyapi.com/api/character/2
    
    convenience init?(url:URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseURl) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseURl+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy:"/")
            if !components.isEmpty {
                let endpointString = components[0]
                var pathComponents:[String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let rmEndpoint = RMEndpoint(
                    rawValue: endpointString
                ) {
                    self.init(endpoint: rmEndpoint,pathComponents:pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy:"?")
            
            if !components.isEmpty,components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                
                let queryItems:[URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    return URLQueryItem(
                        name: parts[0],
                        value:parts[1]
                    )
                })
                
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint,queryParameters: queryItems)
                    return
                }
            }
        }
        return nil
    }
    
    
}




extension RMRequest {
    static let listCharactersRequest = RMRequest(endpoint: .character)
}
