//
//  PostAPIManager.swift
//  Project Latihan Interview
//
//  Created by Arya Ilham on 27/01/24.
//

import Foundation
import Alamofire
import RxSwift

protocol PostAPIManager {
    func getPosts() -> Observable<[PostDTO]>
}

class PostDefaultAPIManager {
    private let BASE_URL = "https://jsonplaceholder.typicode.com"
    
    private let GET_POSTS = "/posts"
}

extension PostDefaultAPIManager: PostAPIManager {
    func getPosts() -> Observable<[PostDTO]> {
        return Observable.create { observer in
            AF.request(URL(string: self.BASE_URL + self.GET_POSTS)!)
                .responseDecodable(of: [PostDTO].self) { response in
                    switch response.result {
                    case .success(let success):
                        observer.onNext(success)
                        observer.onCompleted()
                    case .failure(let failure):
                        observer.onError(failure)
                        break
                    }
                }
            return Disposables.create()
        }
        
        
    }
}
