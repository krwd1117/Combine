//
//  Response.swift
//  CombineAPI
//
//  Created by Jeongwan Kim on 2022/07/24.
//

import Foundation

// MARK: - TodoElement
struct Todo: Codable {
    let userID, id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}
