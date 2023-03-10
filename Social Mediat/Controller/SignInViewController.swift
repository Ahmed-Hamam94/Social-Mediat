//
//  SignInViewController.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 24/02/2023.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var signInBtn: UIButton!{
        didSet{
            signInBtn.layer.shadowColor = UIColor.gray.cgColor
            signInBtn.layer.shadowOpacity = 0.5
            signInBtn.layer.shadowOffset = CGSize(width: 0, height: 10)
            signInBtn.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var goToRgisterBtn: UIButton!{
        didSet{
            goToRgisterBtn.layer.shadowColor = UIColor.gray.cgColor
            goToRgisterBtn.layer.shadowOpacity = 0.5
            goToRgisterBtn.layer.shadowOffset = CGSize(width: 0, height: 10)
            goToRgisterBtn.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    
    var usernetworkProtocol : UserNetworkProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernetworkProtocol = UserNetworkService()
        firstNameTxt.text = "ahmed"
        lastNameTxt.text = "hamam"
        
    }
    
    func signInUser(){
        guard let firstName = firstNameTxt.text, let lastName = lastNameTxt.text else{return}
        usernetworkProtocol?.signInUser(firstName: firstName, lastName: lastName, completionHandler: {
            [weak self] user, errorMessage in
            guard let self = self else{return}
            if let message = errorMessage{
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
            }else{
                guard let signINUser = user else{return}
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") {
                    UserManager.logedUser = signINUser
                    self.present(vc, animated: true)
                }
                
            }
        })
    }
    
    
    @IBAction func signInButton(_ sender: Any) {
        signInUser()
    }
    
    @IBAction func goToRegisterButton(_ sender: Any) {
        guard let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else{return}
        self.present(registerVC, animated: true)
    }
    
}
