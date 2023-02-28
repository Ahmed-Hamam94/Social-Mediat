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
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!{
        didSet{
            tagsCollectionView.delegate = self
            tagsCollectionView.dataSource = self
            setUptagsCell()
        }
    }
    var tags = [String]()
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
    func setUptagsCell(){
        tagsCollectionView.register(UINib(nibName: "TagsPostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TagsPostCollectionViewCell")
    }
}

extension PostTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsPostCollectionViewCell", for: indexPath) as? TagsPostCollectionViewCell else{return TagsPostCollectionViewCell()}
        cell.tagNameLabel.text = "#\(tags[indexPath.row])"
        return cell
    }
    
    
}
