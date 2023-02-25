//
//  Comment.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 20/02/2023.
//

import Foundation

//struct Comment: Decodable {
//
//    var data: [CommentData]
//    let total: Int
//    let page: Int
//    let limit: Int
//    
////     enum CodingKeys: String, CodingKey {
////            case data = "allData"
////            case total = "total"
////            case page = "page"
////            case limit = "limit"
////        }
//}
struct CommentData: Decodable {

    let id: String
    let message: String
    let owner: Ownerr
    let post: String
    let publishDate: String
    
//     enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case message = "message"
//        case owner = "ownerComment"
//        case post = "post"
//        case publishDate = "publishDate"
//    }

}
struct Ownerr: Decodable {

    let id: String
    let title: String?
    let firstName: String?
    let lastName: String?
    let picture: String?

}
