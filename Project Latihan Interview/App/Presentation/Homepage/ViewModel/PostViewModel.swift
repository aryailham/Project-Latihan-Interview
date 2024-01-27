//
//  PostViewModel.swift
//  Project Latihan Interview
//
//  Created by Arya Ilham on 27/01/24.
//

import Foundation
import RxSwift

protocol PostViewModel{
    var posts: Observable<[Post]> { get }
    var error: PublishSubject<String> { get }
    func viewDidLoad()
}

class PostDefaultViewModel: PostViewModel {
    let repository: PostRepository
    
    var postsStream = PublishSubject<[Post]>()
    var posts: Observable<[Post]> {
        return postsStream.distinctUntilChanged()
            .asObservable()
    }
    var postRawData: [Post] = []
    
    var error = PublishSubject<String>()
    
    init(repository: PostRepository) {
        self.repository = repository
    }
    
    func viewDidLoad() {
        self.getPostsData()
    }
    
    private func getPostsData() {
        self.repository.fetchPost { result in
            switch result {
            case .success(let success):
                self.postRawData = success
                self.postsStream.onNext(self.postRawData)
            case .failure(let failure):
                self.error.onNext(failure.localizedDescription)
            }
        }
    }
}
