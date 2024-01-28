//
//  Posts+Decodable.swift
//  Project Latihan Interview
//
//  Created by Arya Ilham on 27/01/24.
//

import Foundation

struct PostDTO: Codable {
    private enum codingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

// MARK: - Mapping To Domain
extension PostDTO {
    func toDomain() -> Post {
        return Post(userId: self.userId,
                    id: self.id,
                    title: self.title,
                    body: self.body)
    }
}

// MARK: - Mapping to Persistent storage model
extension PostDTO {
    func toRealmModel() -> PostDataModel {
        let realmModel = PostDataModel()
        realmModel.id = self.id
        realmModel.userId = self.userId
        realmModel.title = self.title
        realmModel.body = self.body
        return realmModel
    }
}
