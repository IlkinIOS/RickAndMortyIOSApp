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
    
    enum RMServiceError:Error {
        case failedToCreateRequest
        case failedToGetData
    }

    /// Send RIck and Morty API call
    /// - Parameters:
    ///   - request: Request Instance
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(
        _ request:RMRequest ,
        expecting type: T.Type,
        completion: @escaping(Result<T,Error>) -> Void
    ) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        
        
        let task =  URLSession.shared.dataTask(with: urlRequest) { data, _ , error in
            
            guard let data = data,error == nil else {
                completion(.failure( error ?? RMServiceError.failedToGetData))
                return
            }
            // Decode Response into JSON
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
                catch {
                    completion(.failure(error))
            }
        }
        task.resume()
        
        
    }
    
    //MARK: - Private
    private func request(from rmRequest:RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil}
        var request = URLRequest(url:url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
    
    
    
    
    
}
  
