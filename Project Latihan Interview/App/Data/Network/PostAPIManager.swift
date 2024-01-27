//
//  PostAPIManager.swift
//  Project Latihan Interview
//
//  Created by Arya Ilham on 27/01/24.
//

import Foundation
import Alamofire

protocol PostAPIManager {
    func getPosts(completion: @escaping ((Result<[PostDTO], Error>) -> Void))
}

class PostDefaultAPIManager {
    private let BASE_URL = "https://jsonplaceholder.typicode.com"
    
    private let GET_POSTS = "/posts"
}

extension PostDefaultAPIManager: PostAPIManager {
    func getPosts(completion: @escaping ((Result<[PostDTO], Error>) -> Void)) {
        AF.request(URL(string: BASE_URL + GET_POSTS)!)
            .responseDecodable(of: [PostDTO].self) { response in
                switch response.result {
                case .success(let success):
                    // send data back to repository
                    completion(.success(success))
                    break
                case .failure(let failure):
                    // send error to repository
                    completion(.failure(failure))
                    break
                }
            }
    }
}
