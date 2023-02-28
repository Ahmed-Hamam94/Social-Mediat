//
//  UserNetworkService.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 23/02/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol UserNetworkProtocol{
    
    func getSpecificUser(userId: String,completionHandler: @escaping (UserData) -> Void)
    func createNewUser(firstName: String,lastName: String,email: String,completionHandler: @escaping (UserData?,String?) -> Void)
    
    func signInUser(firstName: String,lastName: String,completionHandler: @escaping (UserData?,String?) -> Void)
    
    func updateUserInfo
    (userId: String,title: String,phone: String,gender: String,picture: String,completionHandler: @escaping (UserData?,String?) -> Void)
    
}

class UserNetworkService: Api, UserNetworkProtocol {
    
    func getSpecificUser(userId: String, completionHandler: @escaping (UserData) -> Void) {
        let url = "\(baseUrl)/user/\(userId)"
        AF.request(url,method: .get,encoding: JSONEncoding.default,headers: headers).responseDecodable(of: UserData.self) { response in
            guard let postsRespone = response.value else {return}
            completionHandler(postsRespone)
        }
    }
    
    func createNewUser(firstName: String,lastName: String,email: String,completionHandler: @escaping (UserData?,String?) -> Void) {
        let url = "\(baseUrl)/user/create"
        let param = [   "firstName": firstName,
                        "lastName": lastName,
                        "email": email]
        AF.request(url,method: .post,parameters: param,encoding: JSONEncoding.default,headers: headers).validate().response { response in
            switch response.result {
            case .success:
                print("Validation Successful")
                let jsonData = JSON(response.value as Any)
                let decoder = JSONDecoder()
                do{
                    let result = try decoder.decode(UserData.self, from: jsonData.rawData())
                    print(result)
                    completionHandler(result,nil)
                }catch let error{
                    print(error)
                }
            case let .failure(errorr):
                print(errorr)
                
                let respoData = JSON(response.data ?? "")
                let data = respoData["data"]
                let emailError = data["email"].stringValue
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                let errorMsg = emailError + " " + firstNameError + " " + lastNameError
                print(errorMsg)
                completionHandler(nil,errorMsg)
            }
        }
    }
    
    func signInUser(firstName: String,lastName: String,completionHandler: @escaping (UserData?,String?) -> Void){
        let url = "\(baseUrl)/user"
        let param = [ "created" : "1" ]
        AF.request(url,method: .get,parameters: param,encoder: URLEncodedFormParameterEncoder.default,headers: headers).validate().response { response in
            switch response.result {
            case .success:
                print("Validation Successful")
                let jsonData = JSON(response.value as Any)
                let data = jsonData["data"]
                let decoder = JSONDecoder()
                do{
                    let usersResult = try decoder.decode([UserData].self, from: data.rawData())
                    print(usersResult)
                    var foundUser : UserData?
                    for user in usersResult{
                        if user.firstName == firstName && user.lastName == lastName{
                            foundUser = user
                            break
                        }
                    }
                    if let foundUser = foundUser{
                        completionHandler(foundUser,nil)
                    }else{
                        completionHandler(nil,"The FirstName or The LastName dose not match any user.")
                        
                    }
                    
                    
                }catch let error{
                    print(error)
                }
            case let .failure(errorr):
                print(errorr)
                
                let respoData = JSON(response.data ?? "")
                let data = respoData["data"]
                let emailError = data["email"].stringValue
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                let errorMsg = emailError + " " + firstNameError + " " + lastNameError
                print(errorMsg)
                completionHandler(nil,errorMsg)
            }
        }
        
    }
    
    func updateUserInfo
    (userId: String,title: String,phone: String,gender: String,picture: String,completionHandler: @escaping (UserData?,String?) -> Void){
        
        let url = "\(baseUrl)/user/\(userId)"
        let param = ["title" : title ,"phone" : phone, "gender" : gender, "picture" : picture ]
        AF.request(url,method: .put,parameters: param,encoder: JSONParameterEncoder.default,headers: headers).validate().response { response in
            switch response.result {
            case .success:
                print("Validation Successful")
                let jsonData = JSON(response.value as Any)
                
                let decoder = JSONDecoder()
                do{
                    let userResult = try decoder.decode(UserData.self, from: jsonData.rawData())
                    print(userResult)
                    completionHandler(userResult,nil)
                    
                }catch let error{
                    print(error)
                }
            case let .failure(errorr):
                print(errorr)
                
                let respoData = JSON(response.data ?? "")
                let data = respoData["data"]
                let emailError = data["email"].stringValue
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                let errorMsg = emailError + " " + firstNameError + " " + lastNameError
                print(errorMsg)
                completionHandler(nil,errorMsg)
            }
        }
        
    }
}

