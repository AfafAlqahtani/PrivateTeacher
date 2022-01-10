//
//  LoginViewController.swift
//  PrivateTeacher
//
//  Created by Afaf Yahya on 24/05/1443 AH.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var viewoutlit: UIView!
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        Styl corner to the view
        self.viewoutlit.layer.cornerRadius = 15
        
        //        Shadow To view
        viewoutlit.layer.shadowOffset = CGSize(width: 10, height: 10)
        viewoutlit.layer.shadowRadius = 5
        viewoutlit.layer.shadowOpacity = 0.3
        
    }
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet{
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func handleLogin(_ sender: Any) {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    Alert.showAlert(strTitle: "Error", strMessage: error.localizedDescription, viewController: self)
                    Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                    print("Registration Storage Download Url Error",error.localizedDescription)
                }
                if let _ = authResult {
                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController {
                        vc.modalPresentationStyle = .fullScreen
                        Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var emailLabelLanguage2: UILabel!{
        didSet{
            emailLabelLanguage2.text = "Email".localizeed
            
        }
    }
    
    @IBOutlet weak var passwordLabelLanguagee: UILabel!{
        didSet{
            passwordLabelLanguagee.text = "PassWord".localizeed
        }
    }
    
    @IBOutlet weak var sigiInBottunLangage: UIButton!{
        didSet {
            sigiInBottunLangage.setTitle(NSLocalizedString("Signin", tableName: "Localizable",  comment: ""), for: .normal)
        }
    }
}
