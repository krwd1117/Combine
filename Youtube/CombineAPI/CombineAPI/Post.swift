//
//  Post.swift
//  CombineAPI
//
//  Created by Jeongwan Kim on 2022/07/24.
//

import Foundation

// MARK: - Post
struct Post: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
