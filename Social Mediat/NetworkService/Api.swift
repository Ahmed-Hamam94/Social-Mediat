//
//  Api.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 23/02/2023.
//

import Foundation
import Alamofire
class Api{
    let appId = "63f493ef7559a945cfae2227"
    let baseUrl = "https://dummyapi.io/data/v1"
    lazy var headers : HTTPHeaders = ["app-id" : appId]
}
