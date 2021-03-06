//
//  URL+.swift
//  FitGoal
//
//  Created by Eliany Barrera on 9/3/20.
//  Copyright © 2020 Eliany Barrera. All rights reserved.
//

import UIKit
extension URL {
    func fetch <T: Decodable> (completion: @escaping (Result <[T], Error>) -> Void) {
        URLSession.shared.dataTask(with: self) { data, _, error in
            guard let data = data else {
                guard let error = error else {
                    assertionFailure("Error shouldn't be nil when there is no data")
                    return
                }
                completion(.failure(error))
                return
            }
            
            do {
                let array = try JSONDecoder().decode([T].self, from: data)
                completion(.success(array))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    func downloadImage(completion: @escaping (Result<UIImage, Error>) -> Void) -> URLSessionDataTask? {
        return URLSession.shared.dataTask(with: self) { (data, response, error) in
            guard let data = data else {
                guard let error = error else {
                    fatalError("Error shouldn't be nil")
                }
                completion(.failure(error))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(NetworkError.invalidImage))
                return
            }
            completion(.success(image))
        }
    }
}

private enum NetworkError: Error {
    case invalidImage
}
