//
//  PostDataModel.swift
//  Project Latihan Interview
//
//  Created by Arya Ilham on 27/01/24.
//

import Foundation
import RealmSwift

class PostDataModel: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var userId: Int
    @Persisted var title: String
    @Persisted var body: String
}

extension PostDataModel {
    func toDomain() -> Post {
        return Post(userId: self.userId,
                    id: self.id,
                    title: self.title,
                    body: self.body)
    }
}
