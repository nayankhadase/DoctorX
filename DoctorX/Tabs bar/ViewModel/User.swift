//
//  User.swift
//  DoctorX
//
//  Created by Nayan Khadase on 13/12/23.
//

import Foundation

class User{
    var name: String?
    var email: String?
    var userId: String?
    var gender: String?
    var phoneNumber: String?
    var profileImagePath: String?
    
    static let shared = User()
    private init(){}
    
    deinit{
        print("deinit")
        name = nil
        email = nil
        userId = nil
        gender = nil
        phoneNumber = nil
        profileImagePath = nil
    }
    
    func deleteUser(){
        KeychainStore.deleteUserCredential(for: email ?? "")
        StoreData.deleteFromStore(for: UDKey.userEmail)
        name = nil
        email = nil
        userId = nil
        gender = nil
        phoneNumber = nil
        profileImagePath = nil
    }
    
    func setuser(usr: UserModel){
        User.shared.userId = usr.id
        User.shared.email = usr.email
        User.shared.name = usr.name
        User.shared.gender = usr.gender
        User.shared.phoneNumber = usr.phoneNumber
        User.shared.profileImagePath = usr.getProfileImagePath
    }
}
