//
//  PostViewController.swift
//  PrivateTeacher
//
//  Created by Afaf Yahya on 24/05/1443 AH.
//

import UIKit
import Firebase
class PostViewController: UIViewController {
    var selectedPost:Post?
    var selectedPostImage:UIImage?
    var selectUserImage:UIImage?
    
    @IBOutlet weak var postImageView: UIImageView! {
        didSet {
            postImageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
            postImageView.addGestureRecognizer(tapGesture)
            
//            select image
            postImageView.layer.borderColor = UIColor.systemCyan.cgColor
            postImageView.layer.borderWidth = 3.0
            postImageView.layer.masksToBounds = true
            postImageView.isUserInteractionEnabled = true
        }
        
    }
    
    @IBOutlet weak var imageShow: UIImageView!{
        didSet{
            imageShow.layer.borderColor = UIColor.tertiarySystemBackground.cgColor
               imageShow.layer.borderWidth = 0
               imageShow.layer.cornerRadius = 20
                       imageShow.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

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
                       viewOfImageShow.layer.masksToBounds = true
                       viewOfImageShow.isUserInteractionEnabled = true
                  }
    }
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var stageTextFielf: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var teachingPlaceTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    let activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedPost = selectedPost,
        let selectedImage = selectedPostImage{
            print("!!!!!!!!!!! POST DATA",selectedPost)
            stageTextFielf.text = selectedPost.stage
            genderTextField.text = selectedPost.gender
            phoneNumberTextField.text = selectedPost.phoneNumber
            subjectTextField.text = selectedPost.subject
            teachingPlaceTextField.text = selectedPost.teachingPlace
            cityTextField.text = selectedPost.city
            postImageView.image = selectedImage
            descriptionTextField.text = selectedPost.description
            actionButton.setTitle("Update Post".localizeed, for: .normal)
            let deleteBarButton = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(handleDelete))
            self.navigationItem.rightBarButtonItem = deleteBarButton
        }else {
            actionButton.setTitle("Add Post".localizeed, for: .normal)
            self.navigationItem.rightBarButtonItem = nil
            
        }
        // Do any additional setup after loading the view.
    }
    @objc func handleDelete (_ sender: UIBarButtonItem) {
        let ref = Firestore.firestore().collection("posts")
        if let selectedPost = selectedPost {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            ref.document(selectedPost.id).delete { error in
                if let error = error {
                    print("Error in db delete",error)
                }else {
                    // Create a reference to the file to delete
                    let storageRef = Storage.storage().reference(withPath: "posts/\(selectedPost.user.id)/\(selectedPost.id)")
                    // Delete the file
                    storageRef.delete { error in
                        if let error = error {
                            print("Error in storage delete",error)
                        }
                            self.activityIndicator.stopAnimating()
                            self.navigationController?.popViewController(animated: true)
                        }
                    
                    
                }
            }
        }
    }
    
    @IBAction func handleActionTouch(_ sender: Any) {
        
        if let image = postImageView.image,
           let imageData = image.jpegData(compressionQuality: 0.25),
           let stage = stageTextFielf.text,
           let subject = subjectTextField.text,
           let city = cityTextField.text,
           let gender = genderTextField.text,
           let phoneNumber = phoneNumberTextField.text,
           let description = descriptionTextField.text,
           let teachingPlace = teachingPlaceTextField.text,
//
           let currentUser = Auth.auth().currentUser {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
//            ref.addDocument(data:)
            var postId = ""
            if let selectedPost = selectedPost {
                postId = selectedPost.id
            }else {
                postId = "\(Firebase.UUID())"
            }
            let storageRef = Storage.storage().reference(withPath: "posts/\(currentUser.uid)/\(postId)")
            let updloadMeta = StorageMetadata.init()
            updloadMeta.contentType = "image/jpeg"
            storageRef.putData(imageData, metadata: updloadMeta) { storageMeta, error in
                if let error = error {
                    print("Upload error",error.localizedDescription)
                }
                storageRef.downloadURL { url, error in
                    var postData = [String:Any]()
                    if let url = url {
                        let db = Firestore.firestore()
                        let ref = db.collection("posts")
                        if let selectedPost = self.selectedPost {
                            postData = [
                                "userId":selectedPost.user.id,
                                "stage":stage,
                                "subject":subject,
                                "city":city,
                                "gender":gender,
                                "phoneNumber":phoneNumber,
                                "description":description,
                                "teachingPlace":teachingPlace,
                                "imageUrl":url.absoluteString,
                                "createdAt":selectedPost.createdAt ?? FieldValue.serverTimestamp(),
                                "updatedAt": FieldValue.serverTimestamp()
                            ]
                        }else {
                            postData = [
                                "userId":currentUser.uid,
                                "stage":stage,
                                "subject":subject,
                                "city":city,
                                "gender":gender,
                                "teachingPlace":teachingPlace,
                                "phoneNumber":phoneNumber,
                                "description":description,
                                "imageUrl":url.absoluteString,
                                "createdAt":FieldValue.serverTimestamp(),
                                "updatedAt": FieldValue.serverTimestamp()
                            ]
                        }
                        ref.document(postId).setData(postData) { error in
                            if let error = error {
                                print("FireStore Error",error.localizedDescription)
                            }
                            Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                            self.navigationController?.popViewController(animated: true)
                            
                        }
                    }
                }
            }
        }
    }
    @IBOutlet weak var stageLabelLanguage: UILabel!{
        didSet{
            stageLabelLanguage.text = "Stage".localizeed
        }
    }
    @IBOutlet weak var genderLabelLang: UILabel!{
        didSet{
            genderLabelLang.text = "Gender".localizeed
        }
    }
    
    @IBOutlet weak var phoneNumberLang: UILabel!{
        didSet{
            phoneNumberLang.text = "Phone Number".localizeed
        }
    }
    
    @IBOutlet weak var teachingLabelLng: UILabel!{
        didSet{
            teachingLabelLng.text = "Teaching Place".localizeed
        }
    }
    
    @IBOutlet weak var subjectLabelLang: UILabel!{
        didSet{
            subjectLabelLang.text = "Subject".localizeed
        }
    }
    
    @IBOutlet weak var cityLabelLanguage: UILabel!{
        didSet{
            cityLabelLanguage.text = "City".localizeed
        }
    }
    
    @IBOutlet weak var discreptionLabelLanguage: UILabel!{
        didSet{
            discreptionLabelLanguage.text = "Brife about me".localizeed
        }
    }
    
    }

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func chooseImage() {
        self.showAlert()
    }
    private func showAlert() {
        
        let alert = UIAlertController(title: "Choose Profile Picture", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //get image from source type
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        postImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}


