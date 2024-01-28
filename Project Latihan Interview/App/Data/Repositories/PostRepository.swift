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
    typealias localDataSource = PostPersistentStorageManager
    
    private let remote: remoteDataSource
    private let local: localDataSource
    
    init(remote: remoteDataSource, local: localDataSource) {
        self.remote = remote
        self.local = local
    }
}

extension PostDefaultRepository: PostRepository {
    func fetchPost() ->  Observable<[Post]> {
        return remote.getPosts()
            .map { posts in
                self.local.saveList(posts: posts).map { postDataModel in
                    return postDataModel.toDomain()
                }
            }
    }
}
