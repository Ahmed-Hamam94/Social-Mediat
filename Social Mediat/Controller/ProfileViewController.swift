//
//  ProfileViewController.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 22/02/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    var usernetworkProtocol : UserNetworkProtocol?
    var user : Dataa?
    var profile : UserData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernetworkProtocol = UserNetworkService()
        setUpPost()
        getUser()
    }
    
    
    func setUpPost(){
        userNameLabel.text = (user?.owner.firstName ?? "") + " " + (user?.owner.lastName ?? "")
        userImageView.setUpImageFromString(stringUrl: user?.owner.picture ?? "  https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg")
        userImageView.makeCircular()
        emailLabel.text = profile?.email
        phoneLabel.text = profile?.phone
        genderLabel.text = profile?.gender
        countryLabel.text = (profile?.location?.country ?? "") + "-" + (profile?.location?.city ?? "")
        
    }
    
    func getUser(){
        Indicator.shared.setUpIndicator(view: view)
        
        usernetworkProtocol?.getSpecificUser(userId: user?.owner.id ?? "", completionHandler: { [weak self] user in
            guard let self = self else{return}

            self.profile = user
            DispatchQueue.main.async {
                self.setUpPost()
                Indicator.shared.indicator.stopAnimating()
            }
        })
    }
    
}
