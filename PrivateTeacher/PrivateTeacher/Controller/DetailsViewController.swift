//
//  DetailsViewController.swift
//  PrivateTeacher
//
//  Created by Afaf Yahya on 24/05/1443 AH.
//

import UIKit

class DetailsViewController: UIViewController {
    var selectedPost:Post?
    var selectedPostImage:UIImage?
    @IBOutlet weak var postStageLabel: UILabel!
    @IBOutlet weak var postGenderLabel: UILabel!
    @IBOutlet weak var postPhoneNumberLabel: UILabel!
    @IBOutlet weak var postTeachingPlaceLabel: UILabel!
    @IBOutlet weak var postSubjectLabel: UILabel!
    @IBOutlet weak var postCityLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UITextField!
    @IBOutlet weak var postImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedPost = selectedPost,
        let selectedImage = selectedPostImage{
            postStageLabel.text = selectedPost.stage
            postSubjectLabel.text = selectedPost.subject
            postCityLabel.text = selectedPost.city
            postGenderLabel.text = selectedPost.user.gender
            postPhoneNumberLabel.text = selectedPost.user.phoneNumber
            postTeachingPlaceLabel.text = selectedPost.user.teachingPlace
            postDescriptionLabel.text = selectedPost.user.description
            postImageView.image = selectedImage
        }
        // Do any additional setup after loading the view.
    }
}
