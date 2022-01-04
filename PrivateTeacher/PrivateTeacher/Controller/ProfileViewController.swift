//
//  SettingViewController.swift
//  PrivateTeacher
//
//  Created by Afaf Yahya on 24/05/1443 AH.
//

import UIKit
import Firebase
class ProfileViewController: UIViewController {
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
    
    @IBOutlet weak var userImageView: UIImageView!
    
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
