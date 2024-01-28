//
//  PostPersistentStorageManager.swift
//  Project Latihan Interview
//
//  Created by Arya Ilham on 27/01/24.
//

import Foundation
import RealmSwift

protocol PostPersistentStorageManager {
    func saveList(posts: [PostDTO]) -> [PostDataModel]
    func getList() -> [PostDataModel]
}

class PostRealmPersistentStorage {
    let realm: Realm?
    
    init() {
        self.realm = try! Realm()
    }
}

extension PostRealmPersistentStorage: PostPersistentStorageManager {
    func saveList(posts: [PostDTO]) -> [PostDataModel] {
        let postsRealmModel: [PostDataModel] = posts.map { postDTO in
            postDTO.toRealmModel()
        }
        
        do {
            try realm?.write({
                let currentPosts = getList()
                if currentPosts.count > 0 {
                    realm?.delete(currentPosts)
                }
                realm?.add(postsRealmModel)
            })
            let posts = getList()
            return posts.count > 0 ? posts : postsRealmModel
        } catch let error {
            // handle error
            print("error saving post: \(error.localizedDescription)")
            return postsRealmModel
        }
    }
    
    func getList() -> [PostDataModel] {
        if let posts = realm?.objects(PostDataModel.self) {
            return Array(posts)
        } else {
            return []
        }
    }
}
