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
    
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var hiUserLabel: UILabel!
    
    @IBOutlet weak var postTablView: UITableView!
    
    @IBOutlet weak var closeButton: UIButton!
    var postsArray = [Dataa]()
   // var signInUser : UserData?
    var networkProtocol : PostNetworkProtocol?
    var tag : String?
//    let appId = "63f0f841bf380d3a27cfff5c"
//    let url = "https://dummyapi.io/data/v1/post"
//    lazy var headers : HTTPHeaders = ["app-id":appId]
   // let indicator = UIActivityIndicatorView(style: .large)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkProtocol = PostNetworkService()
       // setUpIndicator()
        Indicator.shared.setUpIndicator(view: view)
        checkTags()
        checkUser()
        networkProtocol?.getAllPosts(tag: tag, completionHandler: { post in
            print(post)
            self.postsArray = post.data
            self.postTablView.reloadData()
            Indicator.shared.indicator.stopAnimating()
        })
        
        observeNotification()
//        AF.request(url,method: .get,encoding: JSONEncoding.default,headers: headers).responseDecodable(of: Posts.self) { response in
//            guard let postsRespone = response.value else {return}
//
//            let postsData = postsRespone.data
//            print(postsData)
//            self.postsArray = postsData
//            self.postTablView.reloadData()
//        }
        setUpTable()
        setUpCell()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        Indicator.shared.setUpIndicator(view: view)
//
//    }
    func checkUser(){
        if let user = UserManager.logedUser{   //signInUser
            hiUserLabel.text = "Hello, \(user.firstName)"
        }else{
            hiUserLabel.isHidden = true
        }
    }
    func checkTags(){
        if let myTag = tag{
            tagLabel.text = myTag
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
//    func setUpIndicator(){
//        indicator.center = view.center
//        view.addSubview(indicator)
//        indicator.startAnimating()
//    }
    func observeNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(userSVClicked), name: NSNotification.Name(rawValue: "userSv"), object: nil)
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
    @IBAction func signInOutButton(_ sender: Any) {
        guard let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else{return}
        UserManager.logedUser = nil

        self.present(signInVC, animated: true)
       // UserManager.logedUser = nil
//        self.dismiss(animated: true)
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
        let imgString = post.image
        cell.postImageView.setUpImageFromString(stringUrl: imgString)
        cell.postTextLabel.text = post.text
        cell.userNameLabel.text = post.owner.firstName + " " + post.owner.lastName
        if let imgUserString = post.owner.picture{
            cell.userImageView.setUpImageFromString(stringUrl: imgUserString)

        }
        cell.likesLabel.text = "\(post.likes)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPost = postsArray[indexPath.row]
        if let detailsVC = storyboard?.instantiateViewController(withIdentifier: "PostDetailsViewController") as? PostDetailsViewController{
            detailsVC.post = selectedPost
          // detailsVC.logeddUser = signInUser // 
            present(detailsVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 460
    }
}
