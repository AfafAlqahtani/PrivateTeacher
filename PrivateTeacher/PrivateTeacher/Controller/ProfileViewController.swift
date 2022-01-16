//
//  SettingViewController.swift
//  PrivateTeacher
//
//  Created by Afaf Yahya on 24/05/1443 AH.
//

import UIKit
import Firebase
class ProfileViewController: UIViewController {
    
    var posts = [Post]()
    var selectedPost:Post?
    var selectedPostImage:UIImage?
    var selectUseImage:UIImage?
    
    @IBOutlet weak var imageShow: UIImageView!{
        didSet {
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
    
    
    @IBOutlet var viewShow: UIView!{
        didSet{
            //        Styl corner to the view
            self.viewShow.layer.cornerRadius = 15
          
            
            //        Shadow To Label
            viewShow.layer.shadowOffset = CGSize(width: 10, height: 10)
            viewShow.layer.shadowRadius = 5
            viewShow.layer.shadowOpacity = 0.3
        }
    }
    @IBAction func handleLogout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LandingNavigationController") as? UINavigationController {
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        } catch  {
            print("ERROR in signout",error.localizedDescription)
    }
    
}
    
    @IBOutlet weak var logoutBottunLocalization: UIButton!{
        didSet{
            logoutBottunLocalization.setTitle(NSLocalizedString("logout", tableName: "Localizable",  comment: ""), for: .normal)
        }
}
    
    @IBOutlet weak var userImageView: UIImageView!{
        didSet{
            userImageView.layer.borderColor = UIColor.systemCyan.cgColor
            userImageView.layer.borderWidth = 3.0
            userImageView.layer.cornerRadius = userImageView.bounds.height / 2
            userImageView.layer.masksToBounds = true
            userImageView.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userPhoneNumberLabel: UILabel!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUser()
        

    }
    func getUser(){
        let ref = Firestore.firestore()
        if let currentUser = Auth.auth().currentUser{
            ref.collection("users").document(currentUser.uid).addSnapshotListener { snapshot, error in
                if let error = error {
                    print("DB ERROR Posts",error.localizedDescription)
                }
                if let snapshot = snapshot ,let userData = snapshot.data(){
                    
                    let user = User(dict: userData)
                    self.userImageView.loadImageUsingCache(with: user.imageUrl)
                    self.userNameLabel.text = user.name
                    self.userEmailLabel.text = user.email
                    self.userPhoneNumberLabel.text = user.phoneNumber
                    
                }
            }
        }
    }
}

