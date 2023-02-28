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
    func getAllPosts(page: Int,tag: String?,completionHandler: @escaping(Posts)-> Void)
    func getComments(postId: String,completionHandler: @escaping ([CommentData]) -> Void)
    func createComment(postId: String,userId: String,commentMsg: String,completionHandler: @escaping () -> Void)
    func getAllTags(completionHandler: @escaping([String?])-> Void)
    func addPost(text: String,image: String,userId: String,completionHandler: @escaping () -> Void)
    
}

class PostNetworkService:Api,PostNetworkProtocol{
    
    func getAllPosts(page: Int,tag: String?,completionHandler: @escaping (Posts) -> Void) {
        var url = baseUrl + "/post"
        if var myTag = tag{
            myTag = myTag.trimmingCharacters(in: .whitespaces)
            myTag = myTag.components(separatedBy: CharacterSet.punctuationCharacters).joined(separator: "")
            myTag = myTag.replacingOccurrences(of: " ", with: "")
            url = "\(baseUrl)/tag/\(myTag)/post"
        }
        let param = ["page":"\(page)"]
        
        AF.request(url,method: .get, parameters: param,encoder: URLEncodedFormParameterEncoder.default,headers: headers).responseDecodable(of: Posts.self) { response in
            guard let postsRespone = response.value else {return}
            completionHandler(postsRespone)
        }
    }
    
    
    func getComments(postId: String,completionHandler: @escaping ([CommentData]) -> Void) {
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
    
    
    func addPost(text: String,image: String,userId: String,completionHandler: @escaping () -> Void){
        let url = "\(baseUrl)/post/create"
        let param = [   "text": text,
                        "owner": userId,
                        "image": image]
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
    
    
    
    
}


