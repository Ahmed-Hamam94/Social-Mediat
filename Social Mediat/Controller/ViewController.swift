//
//  ViewController.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 18/02/2023.
//

import UIKit
import Alamofire
class ViewController: UIViewController {
    
    @IBOutlet weak var tagContainerView: UIView!
    
    @IBOutlet weak var containerBtn: ShadowV!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var hiUserLabel: UILabel!
    
    @IBOutlet weak var postTablView: UITableView!
    
    @IBOutlet weak var closeButton: UIButton!
    var postsArray = [Dataa]()
    var networkProtocol : PostNetworkProtocol?
    var tag : String?
    var pageCount = 0
    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkProtocol = PostNetworkService()
        checkTags()
        checkUser()
        getAllPosts()
        observeNotification()
        setUpTable()
        setUpCell()
    }
   
    
    func getAllPosts(){
        Indicator.shared.setUpIndicator(view: view)
        networkProtocol?.getAllPosts(page: pageCount, tag: tag, completionHandler: {  post in
           // guard let self = self else{return}
            print(post)
            self.total = post.total
            self.postsArray.append(contentsOf: post.data)
            self.postTablView.reloadData()
            print(self.postsArray.count)
            Indicator.shared.indicator.stopAnimating()
        })
    }
    func checkUser(){
        if let user = UserManager.logedUser{   //signInUser
            hiUserLabel.text = "Hello, \(user.firstName)"
        }else{
            hiUserLabel.isHidden = true
            containerBtn.isHidden = true
        }
    }
    func checkTags(){
        if let myTag = tag{
            tagLabel.text = myTag
            containerBtn.isHidden = true
        }else{
            tagContainerView.isHidden = true
            closeButton.isHidden = true
        }
    }
    func setUpTable(){
        postTablView.delegate = self
        postTablView.dataSource = self
        postTablView.separatorStyle = .none
    }
    
    func setUpCell(){
        postTablView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
    }
    
    func observeNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(userSVClicked), name: NSNotification.Name(rawValue: "userSv"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(userChanePic), name: NSNotification.Name(rawValue: "changeProfilePic"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(newPostAdded), name: NSNotification.Name("addNewPost"), object: nil)
        
    }
    
    @objc func userSVClicked(notification: Notification){
        if let cell = notification.userInfo?["cell"] as? UITableViewCell{
            if let index = postTablView.indexPath(for: cell){
                let post = postsArray[index.row]
                guard let vC = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else{return}
                vC.user = post
                present(vC, animated: true)
            }
        }
        
    }
    @objc func userChanePic(notification: Notification){
        self.postsArray = []
        self.pageCount = 0
        getAllPosts()
    }
    @objc func newPostAdded(notification: Notification){
        self.postsArray = []
        self.pageCount = 0
        getAllPosts()
    }
    
    @IBAction func signInOutButton(_ sender: Any) {
        guard let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else{return}
        UserManager.logedUser = nil
        
        self.present(signInVC, animated: true)
        
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
    
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else{return PostTableViewCell()}
        let post = postsArray[indexPath.row]
        if  post.image != ""{
            cell.postImageView.setUpImageFromString(stringUrl: post.image )
            
            cell.postImageView.isHidden = false
        }else{
            cell.postImageView.isHidden = true
        }
        cell.postTextLabel.text = "  \(post.text)"
        cell.userNameLabel.text = post.owner.firstName + " " + post.owner.lastName
        if let imgUserString = post.owner.picture{
            cell.userImageView.setUpImageFromString(stringUrl: imgUserString)
        }else{
            cell.userImageView.image = UIImage(systemName: "person")
        }
        
        cell.likesLabel.text = "\(post.likes ?? 1)"
        cell.tags = post.tags ?? [""]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPost = postsArray[indexPath.row]
        if let detailsVC = storyboard?.instantiateViewController(withIdentifier: "PostDetailsViewController") as? PostDetailsViewController{
            detailsVC.post = selectedPost
            present(detailsVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 548
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == postsArray.count - 1 && postsArray.count < total{
            pageCount = pageCount + 1
            getAllPosts()
        }
    }
    
    
}



