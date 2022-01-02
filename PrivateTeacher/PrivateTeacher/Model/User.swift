//
//  User.swift
//  PrivateTeacher
//
//  Created by Afaf Yahya on 24/05/1443 AH.
//

import Foundation

struct User {
    var id = ""
    var name = ""
    var imageUrl = ""
    var email = ""
    var gender = ""
    var phoneNumber = ""
    var subject = ""
    var teachingPlace = ""
    var city = ""
    var description = ""
    
    
    init(dict:[String:Any]) {
        
        if let name = dict["name"] as? String,
           let imageUrl = dict["imageUrl"] as? String,
           let id = dict["userId"] as? String,
           let email = dict["email"] as? String,
           let gender = dict["gender"] as? String,
           let phoneNumber = dict["phoneNumber"] as? String,
           let subject = dict["subject"] as? String,
           let teachingPlace = dict["teachingPlace"] as? String,
           let description = dict["description"] as? String,
           let city = dict["city"] as? String {
            self.name = name
            self.email = email
            self.gender = gender
            self.phoneNumber = phoneNumber
            self.subject = subject
            self.teachingPlace = teachingPlace
            self.city = city
            self.description = description
            self.imageUrl = imageUrl
            self.id = id
        }
            
    }
    
}
