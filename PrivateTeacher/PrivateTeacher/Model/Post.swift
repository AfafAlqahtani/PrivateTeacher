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
//    var teacherName = ""
    var stage = ""
    var subject = ""
    var city = ""
    var imageUrl = ""
    var user:User
    var createdAt:Timestamp?
    
    init(dict:[String:Any],id:String,user:User) {
        if let stage = dict["stage"] as? String,
//           let stage = dict["stage"] as? String,
           let subject = dict["subject"] as? String,
           let city = dict["city"] as? String,
           let imageUrl = dict["imageUrl"] as? String,
           let createdAt = dict["createdAt"] as? Timestamp {
//            self.teacherName = teacherName
            self.stage = stage
            self.subject = subject
            self.city = city
            self.imageUrl = imageUrl
            self.createdAt = createdAt
        }
        self.id = id
        self.user = user
    }
}
