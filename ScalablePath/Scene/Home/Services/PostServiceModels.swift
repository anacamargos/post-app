//
//  PostServiceModels.swift
//  ScalablePath
//
//  Created by Ana Leticia Camargos on 17/03/21.
//

import Foundation

enum PostServiceError: Error {
    case genericError
}

struct UserResponseEntity: Codable {
    let id: UInt
    let name: String
}

struct PostResponseEntity: Codable {
    let userId: UInt
    let id: UInt
    let title: String
    let body: String
}

struct PostCompleteResponse {
    let authorName: String
    let postTitle: String
    let postContent: String
}
