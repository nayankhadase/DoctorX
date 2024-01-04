//
//  Doctor.swift
//  DoctorX
//
//  Created by Nayan Khadase on 12/12/23.
//

import Foundation

struct Doctor: Codable, Hashable{
    let id: String
    let name: String
    let img: String
//    let gender: String
    let type: String
    let phoneNumber: String
    let about: String
    
    enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name, img, type, phoneNumber, about
        }
}
