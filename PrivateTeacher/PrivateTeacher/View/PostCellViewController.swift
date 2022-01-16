//
//  PostCellViewController.swift
//  PrivateTeacher
//
//  Created by Afaf Yahya on 24/05/1443 AH.
//

import UIKit

class PostCellViewController: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postStageLabel: UILabel!
    @IBOutlet weak var postSubjectLabel: UILabel!
    @IBOutlet weak var postCityLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!{
        didSet{
            userImageView.layer.borderColor = UIColor.systemCyan.cgColor
            userImageView.layer.borderWidth = 3.0
            userImageView.layer.cornerRadius = userImageView.bounds.height / 2
            userImageView.layer.masksToBounds = true
            userImageView.isUserInteractionEnabled = true
        }
    }
//
    @IBOutlet weak var postProfileImage: UIImageView!
    @IBOutlet weak var postProfileStageLabel: UILabel!
    @IBOutlet weak var postProfileSubjectLabel: UILabel!
    @IBOutlet weak var postProfileCityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        //        hide keybord
//                let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
//                tap.cancelsTouchesInView = false
//                view.addGestureRecognizer(tap)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with post:Post) -> UITableViewCell {
        postStageLabel.text = post.stage
        postSubjectLabel.text = post.subject
        postCityLabel.text = post.city
        userNameLabel.text = post.user.name
        postImageView.loadImageUsingCache(with: post.imageUrl)
        userImageView.loadImageUsingCache(with: post.user.imageUrl)
        print("name & image",post.user.imageUrl,post.user.name)
        return self
    }
    
    
    @IBOutlet weak var viewShow: UIView!
    
    override func prepareForReuse() {
        userImageView.image = nil
        postImageView.image = nil
        
       
            userImageView.layer.borderColor = UIColor.systemBackground.cgColor
            userImageView.layer.borderWidth = 3.0
            userImageView.layer.cornerRadius = userImageView.bounds.height / 2
            userImageView.layer.masksToBounds = true
            userImageView.isUserInteractionEnabled = true
            
    }
    
    
    @IBOutlet weak var backView: UIView!{
        didSet{

            backView.layer.shadowOffset = CGSize(width: 10, height: 10)
            backView.layer.shadowRadius = 5
            backView.layer.shadowOpacity = 0.3
            
            self.backView.layer.cornerRadius = 15

        }
    }
}


