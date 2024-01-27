//
//  PostRepository.swift
//  Project Latihan Interview
//
//  Created by Arya Ilham on 27/01/24.
//

import Foundation

protocol PostRepository {
    func fetchPost(completion: @escaping ((Result<[Post], Error>) -> Void))
}

class PostDefaultRepository {
    typealias remoteDataSource = PostAPIManager
    
    private let remote: remoteDataSource
    
    init(remote: PostAPIManager) {
        self.remote = remote
    }
}

extension PostDefaultRepository: PostRepository {
    func fetchPost(completion: @escaping ((Result<[Post], Error>) -> Void)) {
        remote.getPosts { response in
            switch response {
            case .success(let success):
                let posts = success.map { post in
                    post.toDomain()
                }
                completion(.success(posts))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
