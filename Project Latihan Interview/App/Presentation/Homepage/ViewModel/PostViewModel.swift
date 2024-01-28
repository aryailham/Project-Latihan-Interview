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
    
    var getPostStream = PublishSubject<Void>()
    var postsStream = PublishSubject<[Post]>()
    var posts: Observable<[Post]> {
        return postsStream.distinctUntilChanged()
            .asObservable()
    }
    var postRawData: [Post] = []
    
    private let disposeBag = DisposeBag()
    
    var error = PublishSubject<String>()
    
    init(repository: PostRepository) {
        self.repository = repository
    }
    
    func viewDidLoad() {
        self.setupStream()
        self.getPostsData()
    }
    
    private func setupStream() {
        getPostStream
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .flatMap { _ in
                self.repository.fetchPost()
            }
            .subscribe { posts in
                self.postsStream.onNext(posts)
            } onError: { error in
                self.error.onNext(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    private func getPostsData() {
        self.getPostStream.onNext(())
    }
}
