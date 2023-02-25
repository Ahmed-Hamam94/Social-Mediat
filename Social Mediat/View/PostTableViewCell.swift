//
//  PostTableViewCell.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 19/02/2023.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
  
    @IBOutlet weak var userSV: UIStackView!{
        didSet{
            userSV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userSVDidTap)))
        }
    }
    
    @IBOutlet weak var postTextLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!{
        didSet{
            //userImageView.layer.cornerRadius = userImageView.frame.width/2
            userImageView.makeCircular()
        }
    }
    
    @IBOutlet weak var likesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func userSVDidTap(){
        print("clicked")
        NotificationCenter.default.post(name: Notification.Name("userSv"),object: nil,userInfo: ["cell":self])
        
    }
}
