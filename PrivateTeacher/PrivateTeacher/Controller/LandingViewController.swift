//
//  ViewController.swift
//  PrivateTeacher
//
//  Created by Afaf Yahya on 20/05/1443 AH.
//

import UIKit

class LandingViewController: UIViewController {
    
    var transparentView = UIView()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBOutlet weak var registerButtonLocalized: UIButton!{
        
        didSet {
            registerButtonLocalized.setTitle(NSLocalizedString("Register", tableName: "Localizable",  comment: ""), for: .normal)
        }
            }
    
    @IBOutlet weak var LogInBottun: UIButton!{
        didSet{
            LogInBottun.setTitle(NSLocalizedString("Log In", tableName: "Localizable",  comment: ""), for: .normal)
        }
      }
    
    @IBOutlet weak var registerNoteLabel: UILabel!{
        didSet{
            
        
        registerNoteLabel.text = "If you ara a new user, please register".localizeed
    }
    
}


    @IBOutlet weak var languageChangeOtlit: UISegmentedControl!
    {
    didSet {
        if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
            switch lang {
            case "ar":
                languageChangeOtlit.selectedSegmentIndex = 0
            case "en":
                languageChangeOtlit.selectedSegmentIndex = 1
            case "fr":
                languageChangeOtlit.selectedSegmentIndex = 2
            default:
                let localLang =  Locale.current.languageCode
                 if localLang == "ar" {
                     languageChangeOtlit.selectedSegmentIndex = 0
                 } else if localLang == "fr" {
                     languageChangeOtlit.selectedSegmentIndex = 2
                 }else {
                     languageChangeOtlit.selectedSegmentIndex = 1
                 }

            }

        }else {
            let localLang =  Locale.current.languageCode
//            UserDefaults.standard.set(localLang, forKey: "AppleLanguages")
             if localLang == "ar" {
                 languageChangeOtlit.selectedSegmentIndex = 0
             } else if localLang == "fr" {
                 languageChangeOtlit.selectedSegmentIndex = 2
             }else {
                 languageChangeOtlit.selectedSegmentIndex = 1
             }
        }
    }
    }

    @IBAction func languageChanged(_ sender: UISegmentedControl) {
        if let lang = sender.titleForSegment(at:sender.selectedSegmentIndex)?.lowercased() {
            UserDefaults.standard.set(lang, forKey: "currentLanguage")
    //        if lang == "Arabic" {
    //            UIView.appearance().semanticContentAttribute = .forceRightToLeft
    //        }else {
    //            UIView.appearance().semanticContentAttribute = .forceLeftToRight
    //        }
    //        UserDefaults.standard.set(lang, forKey: "currentLanguage")
            Bundle.setLanguage(lang)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
            }
        }
    }
    
}

extension String {
    var localizeed: String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
