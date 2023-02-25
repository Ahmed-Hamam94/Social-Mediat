//
//  NetworkService.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 19/02/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol PostNetworkProtocol{
    func getAllPosts(tag: String?,completionHandler: @escaping(Posts)-> Void)
    func getComments(postId: String,completionHandler: @escaping ([CommentData]) -> Void)
    func createComment(postId: String,userId: String,commentMsg: String,completionHandler: @escaping () -> Void)
    func getAllTags(completionHandler: @escaping([String?])-> Void)

}

class PostNetworkService:Api,PostNetworkProtocol{
    
    func getAllPosts(tag: String?,completionHandler: @escaping (Posts) -> Void) {
        var url = baseUrl + "/post"
        //let url = "https://dummyapi.io/data/v1/post"
        if var myTag = tag{
            myTag = myTag.trimmingCharacters(in: .whitespaces)
            myTag = myTag.components(separatedBy: CharacterSet.punctuationCharacters).joined(separator: "")
            myTag = myTag.replacingOccurrences(of: " ", with: "")


            url = "\(baseUrl)/tag/\(myTag)/post"
        }
        
        AF.request(url,method: .get,encoding: JSONEncoding.default,headers: headers).responseDecodable(of: Posts.self) { response in
            guard let postsRespone = response.value else {return}
            completionHandler(postsRespone)
        }
    }
    
    
    func getComments(postId: String,completionHandler: @escaping ([CommentData]) -> Void) {
     //   let urll = "https://dummyapi.io/data/v1/post/\(postId)/comment"
        let url = "\(baseUrl)/post/\(postId)/comment"
        
        AF.request(url,headers: headers).responseJSON { response in
            guard let responeValue = response.value else {return}
            
            let jsonData = JSON(responeValue)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do{
                let result = try decoder.decode([CommentData].self, from: data.rawData())
                print(result)
                completionHandler(result)
            }catch let error{
                print(error)
            }
            
        }
        
    }
    func createComment(postId: String,userId: String,commentMsg: String,completionHandler: @escaping () -> Void) {
        // let url = "https:dummyapi.io/data/v1/user/create"
        let url = "\(baseUrl)/comment/create"
        let param = [   "post": postId,
                        "owner": userId,
                        "message": commentMsg]
        AF.request(url,method: .post,parameters: param,encoding: JSONEncoding.default,headers: headers).validate().response { response in
            switch response.result {
            case .success:
                completionHandler()
 
            case let .failure(errorr):
                print(errorr)

               
                completionHandler()
            }
        }
    }
    func getAllTags(completionHandler: @escaping([String?])-> Void){
        let url = baseUrl + "/tag"
        
        AF.request(url,headers: headers).response { response in
            guard let responeValue = response.value else {return}
            
            let jsonData = JSON(responeValue as Any)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do{
                let tags = try decoder.decode([String?].self, from: data.rawData())
                print(tags)
                completionHandler(tags)
            }catch let error{
                print(error)
            }
            
        }
    }

    
//    func getSpecificUser(userId: String, completionHandler: @escaping (Profile) -> Void) {
//        let url = "https://dummyapi.io/data/v1/user/\(userId)"
//
//        AF.request(url,method: .get,encoding: JSONEncoding.default,headers: headers).responseDecodable(of: Profile.self) { response in
//            guard let postsRespone = response.value else {return}
//            completionHandler(postsRespone)
//        }
//    }
    
    
    
}

/*
 using swiftyJson
 AF.request(url,headers: headers).responseJSON { response in
 let jsonData = JSON(response.value)
 let data = jsonData["data"]
 let decoder = JSONDecoder()
 do{
 let result = try decoder.decode([Data].self, from: data.rawData())
 print(result)
 }catch let error{
 print(error)
 }
 }
 */
