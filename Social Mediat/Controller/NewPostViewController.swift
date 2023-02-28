//
//  NewPostViewController.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 26/02/2023.
//

import UIKit

class NewPostViewController: UIViewController {
    
    @IBOutlet weak var newPostTextField: UITextField!
    
    @IBOutlet weak var newPostImageTxtField: UITextField!
    @IBOutlet weak var imageTxtContainerView: ShadowV!
    
    var postNetworkProtocol : PostNetworkProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postNetworkProtocol = PostNetworkService()
        imageTxtContainerView.isHidden = true
        
    }
    
    func createNewPost(){
        guard let text = newPostTextField.text,!text.isEmpty,let userId = UserManager.logedUser?.id else {return}
        
        postNetworkProtocol?.addPost(text: text, image: newPostImageTxtField.text ?? "", userId: userId, completionHandler: {
            
        })
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func showImageTxtField(_ sender: Any) {
        imageTxtContainerView.isHidden = !imageTxtContainerView.isHidden
    }
    
    
    @IBAction func addNewPost(_ sender: Any) {
        createNewPost()
        newPostTextField.text = ""
        newPostImageTxtField.text = ""
        NotificationCenter.default.post(name: NSNotification.Name("addNewPost"), object: nil,userInfo: nil)
        self.dismiss(animated: true)

    }
}
