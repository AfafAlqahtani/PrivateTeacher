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
    var selectUserImage:UIImage?
    @IBOutlet weak var viewOutlit: UIView!{
        didSet{
            //        Styl corner to the view
            self.viewOutlit.layer.cornerRadius = 15
          
            
            //        Shadow To Label
            viewOutlit.layer.shadowOffset = CGSize(width: 10, height: 10)
            viewOutlit.layer.shadowRadius = 5
            viewOutlit.layer.shadowOpacity = 0.3
        }
    }
    
    @IBOutlet weak var imageShow: UIImageView!{
        didSet{
            imageShow.layer.borderColor = UIColor.tertiarySystemBackground.cgColor
               imageShow.layer.borderWidth = 0
               imageShow.layer.cornerRadius = 20
                       imageShow.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
           //            viewWelcome.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
               imageShow.layer.masksToBounds = true
               imageShow.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var viewOfImageShow: UIView!{
        didSet{
            viewOfImageShow.layer.borderColor = UIColor.tertiarySystemBackground.cgColor
               viewOfImageShow.layer.borderWidth = 0
            viewOfImageShow.layer.cornerRadius = 20
            viewOfImageShow.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
           //            viewWelcome.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            viewOfImageShow.layer.masksToBounds = true
            viewOfImageShow.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postStageLabel: UILabel!
    @IBOutlet weak var postGenderLabel: UILabel!
    @IBOutlet weak var postPhoneNumberLabel: UILabel!
    @IBOutlet weak var postTeachingPlaceLabel: UILabel!
    @IBOutlet weak var postSubjectLabel: UILabel!
    @IBOutlet weak var postCityLabel: UILabel!

    @IBOutlet weak var postDescriptionLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView! {
        didSet{
            userImageView.layer.borderColor = UIColor.systemCyan.cgColor
            userImageView.layer.borderWidth = 3.0
            userImageView.layer.cornerRadius = userImageView.bounds.height / 2
            userImageView.layer.masksToBounds = true
            userImageView.isUserInteractionEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedPost = selectedPost,
           let selectUserImage = selectUserImage{
//        let selectedImage = selectedPostImage{
            print("!!!!!!!!!!!!!!! Post Data",selectedPost)
            userNameLabel.text = selectedPost.user.name
            postStageLabel.text = selectedPost.stage
            postSubjectLabel.text = selectedPost.subject
            postCityLabel.text = selectedPost.city
            postGenderLabel.text = selectedPost.gender
            postPhoneNumberLabel.text = selectedPost.phoneNumber
            postTeachingPlaceLabel.text = selectedPost.teachingPlace
            postDescriptionLabel.text = selectedPost.description
            userImageView.image = selectUserImage
            
         
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
