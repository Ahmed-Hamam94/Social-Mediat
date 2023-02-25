//
//  CommentTableViewCell.swift
//  Social Mediat
//
//  Created by Ahmed Hamam on 20/02/2023.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!{
        didSet{
            userImageView.makeCircular()
        }
    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
