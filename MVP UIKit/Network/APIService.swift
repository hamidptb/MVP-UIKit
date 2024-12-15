//
//  APIService.swift
//  MVP UIKit
//
//  Created by Hamid on 12/15/24.
//

import Foundation

class APIService {
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let articles = try JSONDecoder().decode([Article].self, from: data)
                completion(.success(articles))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
