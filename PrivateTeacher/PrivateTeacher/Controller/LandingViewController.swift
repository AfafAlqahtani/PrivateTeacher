//
//  ViewController.swift
//  PrivateTeacher
//
//  Created by Afaf Yahya on 20/05/1443 AH.
//

import UIKit

class LandingViewController: UIViewController {
    
    var transparentView = UIView()

    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var viewShow: UIView!
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //        Styl corner to the view
        self.viewShow.layer.cornerRadius = 15
        self.logoImage.layer.cornerRadius = 30
        
        //        Shadow To Label
        viewShow.layer.shadowOffset = CGSize(width: 10, height: 10)
        viewShow.layer.shadowRadius = 5
        viewShow.layer.shadowOpacity = 0.3
        
    }

    @IBOutlet weak var registerButtonLocalized: UIButton!{
        
        didSet {
            registerButtonLocalized.setTitle(NSLocalizedString("Register", tableName: "Localizable",  comment: ""), for: .normal)
        }
            }
    @IBOutlet weak var logoLabel: UILabel!{
        didSet{
            logoLabel.text = "Praivate Teacher".localizeed
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
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
               
            case "en":
                languageChangeOtlit.selectedSegmentIndex = 1
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
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
            if lang == "ar" {
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
            }else {
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
            }
            UserDefaults.standard.set(lang, forKey: "currentLanguage")
            Bundle.setLanguage(lang)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
            }
        }
    }
    
    //    to exit button
        @IBAction func rootViewController(segue: UIStoryboardSegue){
            print("Unwind to Root ViewController")
        }
    
}

extension String {
    var localizeed: String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
