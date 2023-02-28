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
    var post : Dataa?
    var comments = [CommentData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postnetworkProtocol = PostNetworkService()
        setUpTable()
        setUpPost()
        setUpCell()
        getComments()
        checkUserComment()
        
    }
    
    func getComments(){
        Indicator.shared.setUpIndicator(view: view)
        
        if let postId = post?.id{
            postnetworkProtocol?.getComments(postId: postId,completionHandler: { [weak self] comment in
                guard let self = self else{return}

                print(postId)
                self.comments = comment
                
                self.commentsTableView.reloadData()
                Indicator.shared.indicator.stopAnimating()
                
            })
        }
        
    }
    
    func setUpPost(){
        userNameLabel.text = (post?.owner.firstName ?? "") + " " + (post?.owner.lastName ?? "")
        userImageView.setUpImageFromString(stringUrl: post?.owner.picture ?? "")
        userImageView.makeCircular()
        postTextLabel.text = post?.text
        if  post?.image != ""{
            postImageView.setUpImageFromString(stringUrl: post?.image ?? "" )
            
            postImageView.isHidden = false
        }else{
            postImageView.isHidden = true
            
        }
        likesLabel.text = "\(post?.likes ?? 1)"
    }
    
    func setUpTable(){
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
    }
    
    func setUpCell(){
        commentsTableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
    }
    
    func checkUserComment(){
        if UserManager.logedUser == nil{  //logeddUser
            commentSV.isHidden = true
        }
    }
    
    func addComment(){
        guard let commentText = commentTextField.text,!commentText.isEmpty ,let logedUser =  UserManager.logedUser, let postId = post?.id else{return}
        Indicator.shared.setUpIndicator(view: view)
        
        postnetworkProtocol?.createComment(postId: postId, userId: logedUser.id, commentMsg: commentText, completionHandler: { [weak self]  in
            guard let self = self else{return}
            self.getComments()
            self.commentTextField.text = ""
        })
    }
    
    @IBAction func addCommentButton(_ sender: Any) {
        addComment()
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension PostDetailsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as? CommentTableViewCell else{return CommentTableViewCell()}
        
        let comment = comments[indexPath.row]
        
        cell.commentMessageLabel.text = comment.message
        
        if let lastName = comment.owner.lastName, let firstName = comment.owner.firstName{
            cell.userNameLabel.text =  firstName + " " + lastName
        }
        
        if  comment.owner.picture != nil{
            cell.userImageView.setUpImageFromString(stringUrl: comment.owner.picture ??  "")
            
        }else{
            cell.userImageView.image = UIImage(systemName: "person")
            
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
