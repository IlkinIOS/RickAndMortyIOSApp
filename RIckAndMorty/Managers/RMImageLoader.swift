//
//  RMImageLoader.swift
//  RIckAndMorty
//
//  Created by Ilkin Murtuzayev on 24.02.23.
//

import Foundation



/// Here before we had this functionality in RMCharacterCollectionViewViewModel then for being able to use this functionality multiple times we created singleton and used it inside of the RMCharacterCollectionViewViewModel in a simpler form 

final class RMImageLoader {
    
    static let shared = RMImageLoader()

    private let imageDataCache = NSCache<NSString,NSData>()

    private init() {}

    func downloadImage(_ url:URL,completion:@escaping (Result<Data, Error>)  -> Void) {
        let key = url.absoluteString as NSString
        
        if let data = imageDataCache.object(forKey: key) {
             
            completion(.success(data as Data))
            return
        }
        
        let request = URLRequest(url:url)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _ ,error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            
            completion(.success(data))
            
        }
        task.resume()
    }
}
