//
//  PostUseCase.swift
//  Project Latihan Interview
//
//  Created by Arya Ilham on 27/01/24.
//

import Foundation

protocol PostUseCase {
    func fetchPosts(completion: @escaping ((Result<[Post], Error>) -> Void))
}

class PostDefaultUseCase {
    let repository: PostRepository
    
    init(repository: PostRepository) {
        self.repository = repository
    }
}

extension PostDefaultUseCase: PostUseCase {
    func fetchPosts(completion: @escaping ((Result<[Post], Error>) -> Void)) {
        repository.fetchPost { response in
            switch response {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
