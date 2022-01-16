//
//  Post.swift
//  PrivateTeacher
//
//  Created by Afaf Yahya on 24/05/1443 AH.
//

import Foundation
import Firebase
struct Post {
    var id = ""
    var stage = ""
    var subject = ""
    var city = ""
    var imageUrl = ""
    var gender = ""
    var phoneNumber = ""
    var teachingPlace = ""
    var description = ""
    var user:User
    var createdAt:Timestamp?
    
    init(dict:[String:Any],id:String,user:User) {
        if let stage = dict["stage"] as? String,
//           let stage = dict["stage"] as? String,
           let subject = dict["subject"] as? String,
           let city = dict["city"] as? String,
           let gender = dict["gender"] as? String,
           let imageUrl = dict["imageUrl"] as? String,
           let phoneNumber = dict["phoneNumber"] as? String,
           let description = dict["description"] as? String,
           let teachingPlace = dict["teachingPlace"] as? String,
           let createdAt = dict["createdAt"] as? Timestamp {
//            self.teacherName = teacherName
            self.stage = stage
            self.subject = subject
            self.city = city
            self.imageUrl = imageUrl
            self.createdAt = createdAt
            self.gender = gender
            self.teachingPlace = teachingPlace
            self.phoneNumber = phoneNumber
            self.description = description
        }
        self.id = id
        self.user = user
    }
}
