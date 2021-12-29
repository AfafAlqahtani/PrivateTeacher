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
    
    
    init(dict:[String:Any]) {
        if let id = dict["id"] as? String,
           let name = dict["name"] as? String,
           let imageUrl = dict["imageUrl"] as? String,
           let email = dict["email"] as? String,
           let gender = dict["gender"] as? String,
           let phoneNumber = dict["phoneNumber"] as? String,
           let subject = dict["subject"] as? String,
           let teachingPlace = dict["teachingPlace"] as? String,
           let city = dict["city"] as? String {
            self.name = name
            self.id = id
            self.email = email
            self.gender = gender
            self.phoneNumber = phoneNumber
            self.subject = subject
            self.teachingPlace = teachingPlace
            self.city = city
            self.imageUrl = imageUrl
        }
            
    }
    
}
