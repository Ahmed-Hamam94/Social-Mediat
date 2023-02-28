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
    let likes: Int?
    let tags: [String]?
    let text: String
    let publishDate: String
    let owner: Owner

}


struct Owner: Decodable {

    let id: String
    let title: String?
    let firstName: String
    let lastName: String
    let picture: String?

}
