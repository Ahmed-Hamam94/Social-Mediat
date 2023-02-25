//
//  RegisterViewController.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 23/02/2023.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!{
        didSet{
            registerBtn.layer.shadowColor = UIColor.gray.cgColor
            registerBtn.layer.shadowOpacity = 0.5
            registerBtn.layer.shadowOffset = CGSize(width: 0, height: 10)
            registerBtn.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var goToSignInBtn: UIButton!{
            didSet{
                goToSignInBtn.layer.shadowColor = UIColor.gray.cgColor
                goToSignInBtn.layer.shadowOpacity = 0.5
                goToSignInBtn.layer.shadowOffset = CGSize(width: 0, height: 10)
                goToSignInBtn.layer.cornerRadius = 10
            }
    }
    
    var usernetworkProtocol : UserNetworkProtocol?
    var user : NewUser?
    override func viewDidLoad() {
        super.viewDidLoad()
usernetworkProtocol = UserNetworkService()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButton(_ sender: Any) {
        guard let firstName = firstNameTxt.text, let lastName = lastNameTxt.text, let email = emailTxt.text else{return}
        usernetworkProtocol?.createNewUser(firstName: firstName,lastName: lastName,email: email,completionHandler: { user,errorMsg in
            //let data = user?.data
            //let error = user?.error
           
            if errorMsg != nil {
                let alert = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
            }else{
                //self.user = user
                let alert = UIAlertController(title: "Success", message: "User Created", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)

            }
        })
    }
    
 
    @IBAction func goToSignInButton(_ sender: Any) {
//        guard let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else{return}
//        self.present(signInVC, animated: true)
        self.dismiss(animated: true)
    }
    
}
