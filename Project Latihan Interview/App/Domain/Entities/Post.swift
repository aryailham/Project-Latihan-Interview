//
//  Post.swift
//  Project Latihan Interview
//
//  Created by Arya Ilham on 27/01/24.
//

import Foundation

struct Post: Equatable, Identifiable {
    typealias Identifier = Int
    
    let userId: Int
    let id: Identifier
    let title: String
    let body: String
}
