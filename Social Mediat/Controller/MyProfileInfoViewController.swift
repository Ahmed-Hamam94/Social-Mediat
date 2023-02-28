//
//  MyProfileInfoViewController.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 26/02/2023.
//

import UIKit

class MyProfileInfoViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var gendreTextField: UITextField!
    @IBOutlet weak var imageUrlTextField: UITextField!
    
    var userNetworkProtocol : UserNetworkProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNetworkProtocol = UserNetworkService()
        setUpUserUI()
        getUserInfo()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  setUpUserUI()
    }
    
    func getUserInfo(){
        if let user = UserManager.logedUser{
            userNetworkProtocol?.getSpecificUser(userId: user.id, completionHandler: {[weak self] user in
                guard let self = self else{return}
                DispatchQueue.main.async {
                    self.gendreTextField.text = user.gender
                    self.phoneTextField.text = user.phone
                }
            })
        }
        }
    
    func setUpUserUI(){
        
        userImageView.makeCircular()
        if let user = UserManager.logedUser{
            userNameLabel.text = user.firstName + " " + user.lastName
            userImageView.setUpImageFromString(stringUrl: user.picture ?? "url")
            imageUrlTextField.text = user.picture ?? ""
            titleTextField.text = user.title
        }
        
    }
    
    func addUserInfo(){
        guard let userLoged = UserManager.logedUser,let picture = imageUrlTextField.text else {return}
        Indicator.shared.setUpIndicator(view: view)
        userNetworkProtocol?.updateUserInfo(userId: userLoged.id, title: titleTextField.text!, phone: phoneTextField.text!, gender: gendreTextField.text!, picture: picture, completionHandler: { [weak self] user, message in
            guard let self = self else{return}
            Indicator.shared.indicator.stopAnimating()
            if let responseUser = user {
                guard let title = responseUser.title else{return}
                print(responseUser)
                
                DispatchQueue.main.async {
                    self.titleTextField.text = title
                    
                    self.userImageView.setUpImageFromString(stringUrl: responseUser.picture ?? "")
                }
                
            }
            NotificationCenter.default.post(name: NSNotification.Name("changeProfilePic"), object: nil,userInfo: nil)
            
        })
    }
    
    
    @IBAction func submitButton(_ sender: Any) {
        addUserInfo()
        //setUpUserUI()
    }
    
}
