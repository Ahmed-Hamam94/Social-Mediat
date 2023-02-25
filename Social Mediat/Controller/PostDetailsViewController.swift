//
//  PostDetailsViewController.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 20/02/2023.
//

import UIKit
import Alamofire
class PostDetailsViewController: UIViewController {
// MARK: OUTLETS
    

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBOutlet weak var commentSV: UIStackView!
    var postnetworkProtocol : PostNetworkProtocol?
   // var postsArrayy = [Dataa]()
    var post : Dataa?
   // var postId : Dataa?
    var comments = [CommentData]()
   // var logeddUser : UserData?


    override func viewDidLoad() {
        super.viewDidLoad()

postnetworkProtocol = PostNetworkService()
        setUpTable()
        setUpPost()
        setUpCell()
        getComments()
        checkUserComment()
        //guard let postId = post?.id else {return}
        //let postId = post.id
//        networkProtocol?.getCommentss(postId: postId,completionHandler: { comment in
//            print(postId)
//            self.comments = comment.data
//            self.commentsTableView.reloadData()
//        })
//        let urll = "https://dummyapi.io/data/v1/post/60d21bf967d0d8992e610e9b/comment"
//        let appId = "63f0f841bf380d3a27cfff5c"
//        lazy var headers : HTTPHeaders = ["app-id":appId]
//        AF.request(urll,method: .get,encoding: JSONEncoding.default,headers: headers).responseDecodable(of: Comment.self) { response in
//            guard let postsRespone = response.value else {return}
//           //  print(postId)
//            print(postsRespone)
//        }
    }
    func getComments(){
        if let postId = post?.id{
            Indicator.shared.setUpIndicator(view: view)
            postnetworkProtocol?.getComments(postId: postId,completionHandler: { comment in
                print(postId)
                self.comments = comment
                self.commentsTableView.reloadData()
               // self.indicator.stopAnimating()
                Indicator.shared.indicator.stopAnimating()

            })
        }
    
    }
    
    func setUpPost(){
        userNameLabel.text = (post?.owner.firstName ?? "") + " " + (post?.owner.lastName ?? "")
        userImageView.setUpImageFromString(stringUrl: post?.owner.picture ?? "")
        userImageView.makeCircular()
        postTextLabel.text = post?.text
        postImageView.setUpImageFromString(stringUrl: post?.image ?? "")
        likesLabel.text = "\(post?.likes ?? 1)"
    }
    func setUpTable(){
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
    }
    func setUpCell(){
        commentsTableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
    }
//    func setUpIndicator(){
//        indicator.center = view.center
//        view.addSubview(indicator)
//        indicator.startAnimating()
//    }
    func checkUserComment(){
        if UserManager.logedUser == nil{  //logeddUser
            commentSV.isHidden = true
        }
    }
    
    
    @IBAction func addCommentButton(_ sender: Any) {
        guard let commentText = commentTextField.text, let logedUser =  UserManager.logedUser, let postId = post?.id else{return}
        Indicator.shared.setUpIndicator(view: view)
        postnetworkProtocol?.createComment(postId: postId, userId: logedUser.id, commentMsg: commentText, completionHandler: {
            self.getComments()
            self.commentTextField.text = ""
        })
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension PostDetailsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
       // return 4

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as? CommentTableViewCell else{return CommentTableViewCell()}
        let comment = comments[indexPath.row]
        cell.commentMessageLabel.text = comment.message
        if let lastName = comment.owner.lastName, let firstName = comment.owner.firstName{
            cell.userNameLabel.text =  firstName + " " + lastName
        }
       
        if let userImg = comment.owner.picture{
            cell.userImageView.setUpImageFromString(stringUrl: userImg)

        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
