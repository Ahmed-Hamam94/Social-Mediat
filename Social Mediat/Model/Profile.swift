//
//  Profile.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 23/02/2023.
//

import Foundation
struct NewUser: Decodable {

    //let error: String?
    let data: UserData
}

struct UserData: Decodable {

    let id: String
    let title: String?
    let firstName: String
    let lastName: String
    let picture: String?
    let gender: String?
    let email: String?
    let dateOfBirth: String?
    let phone: String?
    let location: Location?
    let registerDate: String?
    let updatedDate: String?

}

struct Location: Decodable {

    let street: String
    let city: String
    let state: String
    let country: String
    let timezone: String

}
