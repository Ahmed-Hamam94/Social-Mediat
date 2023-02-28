//
//  Api.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 23/02/2023.
//

import Foundation
import Alamofire
class Api{
    let appId = "63fd53c4909ca91a6ab9ab78"  // use your ID
    let baseUrl = "https://dummyapi.io/data/v1"
    lazy var headers : HTTPHeaders = ["app-id" : appId]
}
