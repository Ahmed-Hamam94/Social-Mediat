//
//  Comment.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 20/02/2023.
//

import Foundation


struct CommentData: Decodable {

    let id: String
    let message: String
    let owner: Ownerr
    let post: String
    let publishDate: String
    
}

struct Ownerr: Decodable {

    let id: String
   // let title: String?
    let firstName: String?
    let lastName: String?
   let picture: String?

}
