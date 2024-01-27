//
//  PostUseCase.swift
//  Project Latihan Interview
//
//  Created by Arya Ilham on 27/01/24.
//

import Foundation
import RxSwift

protocol PostUseCase {
    func fetchPosts() -> Observable<[Post]>
}

class PostDefaultUseCase {
    let repository: PostRepository
    
    init(repository: PostRepository) {
        self.repository = repository
    }
}

extension PostDefaultUseCase: PostUseCase {
    func fetchPosts() -> Observable<[Post]> {
        return repository.fetchPost()
    }
}
