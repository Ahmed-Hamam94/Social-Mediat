//
//  Post.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 18/02/2023.
//

import Foundation

struct Posts: Decodable {

    let data: [Dataa]
    let total: Int
    let page: Int
    let limit: Int
    

}

struct Dataa: Decodable {

    let id: String
    let image: String
    let likes: Int
    let tags: [String]
    let text: String
    let publishDate: String
    let owner: Owner
//    let message: String
//    let post: String

}
//struct CommentData: Decodable {
//
//    let id: String
//    let message: String
//    let owner: Ownerr
//    let post: String
//    let publishDate: String
//    
//    private enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case message = "message"
//        case owner = "ownerComment"
//        case post = "post"
//        case publishDate = "publishDate"
//    }
//
//}

struct Owner: Decodable {

    let id: String
    let title: String
    let firstName: String
    let lastName: String
    let picture: String?

}
