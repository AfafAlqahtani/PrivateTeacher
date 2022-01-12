//
//  RegisterViewController.swift
//  PrivateTeacher
//
//  Created by Afaf Yahya on 24/05/1443 AH.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    let imagePickerController = UIImagePickerController()
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var imageSshow: UIImageView!{
        didSet{
      imageSshow.layer.borderColor = UIColor.tertiarySystemBackground.cgColor
            imageSshow.layer.borderWidth = 0
            imageSshow.layer.cornerRadius = 20
            imageSshow.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
 
            imageSshow.layer.masksToBounds = true
            imageSshow.isUserInteractionEnabled = true
          }
    }
    @IBOutlet weak var viewoutlit: UIView!
    
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
    
    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
            userImageView.layer.borderColor = UIColor.systemCyan.cgColor
            userImageView.layer.borderWidth = 3.0
            userImageView.layer.cornerRadius = userImageView.bounds.height / 2
            userImageView.layer.masksToBounds = true
            userImageView.isUserInteractionEnabled = true
            let tabGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
            userImageView.addGestureRecognizer(tabGesture)
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!{
        didSet{
            nameTextField.placeholder = "Enter Your Name".localizeed
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField!{
        didSet{
        emailTextField.placeholder = "Enter Yor Email".localizeed
        }
    }
    
    @IBOutlet weak var phoneNumberTextField: UITextField!{
        didSet{
            phoneNumberTextField.placeholder = "Phone Number".localizeed
        }
    }
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet{
            passwordTextField.isSecureTextEntry = true
            passwordTextField.placeholder = "Passwodr".localizeed
        }
    }
    @IBOutlet weak var confirmPasswordTextField: UITextField!{
        didSet{
            confirmPasswordTextField.isSecureTextEntry = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        // Do any additional setup after loading the view.
        
        //        Styl corner to the view
        self.viewoutlit.layer.cornerRadius = 20
        
        //        Shadow To Label
        viewoutlit.layer.shadowOffset = CGSize(width: 10, height: 10)
        viewoutlit.layer.shadowRadius = 5
        viewoutlit.layer.shadowOpacity = 0.3

        
////        return keybord
        nameTextField.delegate = self
        emailTextField.delegate = self
        phoneNumberTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self

//        hide keybord
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    
    @IBAction func handleRegister(_ sender: Any) {
        
       
        
        if let image = userImageView.image,
           let imageData = image.jpegData(compressionQuality: 0.25),
           let name = nameTextField.text,
           let email = emailTextField.text,
           let phoneNumber = phoneNumberTextField.text,
           let password = passwordTextField.text,
           let confirmPassword = confirmPasswordTextField.text,
           password == confirmPassword {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    Alert.showAlert(strTitle: "Error", strMessage: error.localizedDescription, viewController: self)
                    Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                    print("Registration Auth Error",error.localizedDescription)
                }
                if let authResult = authResult {
                    let storageRef = Storage.storage().reference(withPath: "users/\(authResult.user.uid)")
                    let uploadMeta = StorageMetadata.init()
                    uploadMeta.contentType = "image/jpeg"
                    storageRef.putData(imageData, metadata: uploadMeta) { storageMeta, error in
                        if let error = error {
                            Alert.showAlert(strTitle: "Error", strMessage: error.localizedDescription, viewController: self)
                            Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                            print("Registration Auth Error",error.localizedDescription)
                        }
                        storageRef.downloadURL { url, error in
                            if let error = error {
                                Alert.showAlert(strTitle: "Error", strMessage: error.localizedDescription, viewController: self)
                                Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                                print("Registration Storage Download Url Error",error.localizedDescription)
                            }
                            if let url = url {
                                print("URL",url.absoluteString)
                                let db = Firestore.firestore()
                                let userData: [String:String] = [
                                    "userId":authResult.user.uid,
                                    "name":name,
                                    "email":email,
                                    "imageUrl":url.absoluteString,
                                    "gender" :"f",
                                    "phoneNumber":phoneNumber,
                                    "subject":"jk",
                                    "teachingPlace":"jj",
                                    "city":"l",
                                    "description":"nn"
                                ]
                                db.collection("users").document(authResult.user.uid).setData(userData) { error in
                                    if let error = error {

                                        print("Registration Database error",error.localizedDescription)
                                    }else {
                                        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController {
                                            vc.modalPresentationStyle = .fullScreen
                                            Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                                            self.present(vc, animated: true, completion: nil)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        }else{
                Alert.showAlert(strTitle: "Error", strMessage: "Please enter your information", viewController: self)
        }
                
    }
    
    @IBOutlet weak var nameLableLanguage: UILabel!{
        didSet{
            nameLableLanguage.text = "Full Name".localizeed
        }
    }
    
    @IBOutlet weak var emailLabelLanguage: UILabel!{
        didSet {
            emailLabelLanguage.text = "Email".localizeed
        }
    }
    
    @IBOutlet weak var passwordLabelLanguage: UILabel!{
        didSet {
            passwordLabelLanguage.text = "PassWord".localizeed
        }
    }
    
   
    @IBOutlet weak var passwordLabelLanguage2: UITextField!{
        didSet {
            passwordLabelLanguage2.text = "PassWord".localizeed
        }
    }
    
    
    @IBOutlet weak var rigesterLabelLanguage: UIButton!{
        didSet{
            rigesterLabelLanguage.setTitle(NSLocalizedString("Register", tableName: "Localizable",  comment: ""), for: .normal)
        }
    }
    
    @IBOutlet weak var phoneNumberLabel: UILabel!{
        didSet{
            phoneNumberLabel.text = "Phone Number".localizeed
        }
    }
    
    }
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @objc func selectImage() {
        showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "choose Profile Picture", message: "where do you want to pick your image from?", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { Action in
            self.getImage(from: .camera)
        }
        let galaryAction = UIAlertAction(title: "photo Album", style: .default) { Action in
            self.getImage(from: .photoLibrary)
        }
        let dismissAction = UIAlertAction(title: "Cancle", style: .destructive) { Action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cameraAction)
        alert.addAction(galaryAction)
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
    func getImage( from sourceType: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return}
        userImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
extension RegisterViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


