//
//  Api.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 23/02/2023.
//

import Foundation
import Alamofire
class Api{
    let appId = "63fd4c017d49ec69e2eee25c"  // use your ID
    let baseUrl = "https://dummyapi.io/data/v1"
    lazy var headers : HTTPHeaders = ["app-id" : appId]
}
