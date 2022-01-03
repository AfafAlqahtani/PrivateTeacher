//
//  SettingViewController.swift
//  PrivateTeacher
//
//  Created by Afaf Yahya on 24/05/1443 AH.
//

import UIKit
import Firebase
class SettingViewController: UIViewController {
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
    
//    @IBOutlet weak var languageChangeOtlit: UISegmentedControl!{
//
//
//        didSet {
//            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
//                switch lang {
//                case "Arabic":
//                    languageChangeOtlit.selectedSegmentIndex = 0
//                case "English":
//                    languageChangeOtlit.selectedSegmentIndex = 1
//                case "Frinsh":
//                    languageChangeOtlit.selectedSegmentIndex = 2
//                default:
//                    let localLang =  Locale.current.languageCode
//                     if localLang == "Arabic" {
//                         languageChangeOtlit.selectedSegmentIndex = 0
//                     } else if localLang == "Frinsh"{
//                         languageChangeOtlit.selectedSegmentIndex = 2
//                     }else {
//                         languageChangeOtlit.selectedSegmentIndex = 1
//                     }
//
//                }
//
//            }else {
//                let localLang =  Locale.current.languageCode
//                 if localLang == "Arabic" {
//                     languageChangeOtlit.selectedSegmentIndex = 0
//                 } else if localLang == "Frinsh"{
//                     languageChangeOtlit.selectedSegmentIndex = 2
//                 }else {
//                     languageChangeOtlit.selectedSegmentIndex = 1
//                 }
//            }
//        }
//
//    }
//
//    @IBAction func languageChangeAction(_ sender: UISegmentedControl) {
//        if let lang = sender.titleForSegment(at:sender.selectedSegmentIndex)?.lowercased() {
//            UserDefaults.standard.set(lang, forKey: "currentLanguage")
//            Bundle.setLanguage(lang)
//            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//               let sceneDelegate = windowScene.delegate as? SceneDelegate {
//                sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
//            }
//        }
//
//    }
}




//    extension UITextField{
//        @IBInspectable var doneAccessory: Bool{
//            get{
//                return self.doneAccessory
//            }
//            set (hasDone) {
//                if hasDone{
//                    addDoneButtonOnKeyboard()
//                }
//            }
//        }
//func addDoneButtonOnKeyboard()
//   {
//       let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
//       doneToolbar.barStyle = .default
//
//       let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//       let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
//
//       let items = [flexSpace, done]
//       doneToolbar.items = items
//       doneToolbar.sizeToFit()
//
//       self.inputAccessoryView = doneToolbar
//   }
//
//   @objc func doneButtonAction()
//   {
//       self.resignFirstResponder()
//   }
//}
//
