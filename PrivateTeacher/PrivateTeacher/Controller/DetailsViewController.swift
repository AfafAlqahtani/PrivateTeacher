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
            print("!!!!!!!!!!!!!!! Post Data",selectedPost)
            postStageLabel.text = selectedPost.stage
            postSubjectLabel.text = selectedPost.subject
            postCityLabel.text = selectedPost.city
            postGenderLabel.text = selectedPost.gender
            postPhoneNumberLabel.text = selectedPost.phoneNumber
            postTeachingPlaceLabel.text = selectedPost.teachingPlace
            postDescriptionLabel.text = selectedPost.description
            postImageView.image = selectedImage
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBOutlet weak var stageLabelLanguage2: UILabel!{
        didSet{
        stageLabelLanguage2.text = "Stage".localizeed
    }
    }
    
    @IBOutlet weak var genderLabelLanguage: UILabel!{
        didSet{
            genderLabelLanguage.text = "Gender".localizeed
        }
    }
    
    @IBOutlet weak var phoneNumberLabelLanguage: UILabel!{
        didSet{
            phoneNumberLabelLanguage.text = "Phone Number".localizeed
        }
    }
    @IBOutlet weak var teachingLabelLanguage2: UILabel!{
        didSet{
            teachingLabelLanguage2.text = "Teaching Place".localizeed
        }
    }
    
    @IBOutlet weak var subjectLabelLanguage: UILabel!{
        didSet{
            subjectLabelLanguage.text = "Subject".localizeed
        }
    }
    @IBOutlet weak var cityLabelLanguage: UILabel!{
        didSet{
            cityLabelLanguage.text = "City".localizeed
        }
    }
    
    @IBOutlet weak var discreptionLabelLanguage2: UILabel!{
        didSet{
            discreptionLabelLanguage2.text = "Brife about me".localizeed
        }
    }
    
}
