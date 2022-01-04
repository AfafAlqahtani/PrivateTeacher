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
