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
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with post:Post) -> UITableViewCell {
        postStageLabel.text = post.stage
        postSubjectLabel.text = post.subject
        postCityLabel.text = post.city
        postImageView.loadImageUsingCache(with: post.imageUrl)
        userNameLabel.text = post.user.name
        userImageView.loadImageUsingCache(with: post.user.imageUrl)
        print("name & image",post.user.imageUrl,post.user.name)
        return self
    }
    
    override func prepareForReuse() {
        userImageView.image = nil
        postImageView.image = nil
    }
}
    

