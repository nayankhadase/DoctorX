//
//  UserModel.swift
//  DoctorX
//
//  Created by Nayan Khadase on 13/12/23.
//

import Foundation

struct UserModel: Codable, Hashable{
    let id: String
    let email: String
    let name: String?
    let gender: String?
    let phoneNumber: String?
    let profileImagePath: String?
    
    enum CodingKeys: String, CodingKey{
        case id = "_id"
        case email, name, gender, phoneNumber, profileImagePath
    }
    
    var getProfileImagePath: String?{
        print("profileImagePath \(profileImagePath)")
        guard let profileImagePath = profileImagePath else {return nil}
        return ServerDetails.publicImage + profileImagePath
    }
}
