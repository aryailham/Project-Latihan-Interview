//
//  PostRepository.swift
//  Project Latihan Interview
//
//  Created by Arya Ilham on 27/01/24.
//

import Foundation
import RxSwift

protocol PostRepository {
    func fetchPost() -> Observable<[Post]>
}

class PostDefaultRepository {
    typealias remoteDataSource = PostAPIManager
    
    private let remote: remoteDataSource
    
    init(remote: PostAPIManager) {
        self.remote = remote
    }
}

extension PostDefaultRepository: PostRepository {
    func fetchPost() ->  Observable<[Post]> {
//        return remote.getPosts()
//            .flatMap { postDTO in
//                postDTO.map { post in
//                    return post.toDomain()
//                }
//            }
        return remote.getPosts()
            .map { posts in
                return posts.map { post in
                    post.toDomain()
                }
            }
    }
}
