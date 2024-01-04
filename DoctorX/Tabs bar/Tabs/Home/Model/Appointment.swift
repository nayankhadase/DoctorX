//
//  Appointment.swift
//  DoctorX
//
//  Created by Nayan Khadase on 16/12/23.
//

import Foundation


struct Appointment: Codable, Hashable{
    let id: String
    let userId: String
    let doctor: Doctor
    let date: Double
    let visited: Bool = false
    let consultationType: String
    
    enum CodingKeys: String, CodingKey{
        case id = "_id"
        case userId
        case consultationType
        case date, visited, doctor
    }
    
    var aptDate: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date(timeIntervalSince1970: date)
        return dateFormatter.string(from: date)
    }
    
    var aptTime: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let date = Date(timeIntervalSince1970: date)
        return dateFormatter.string(from: date)
    }
    
    var isUpcomming: Bool{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd h:mm a"
//         Date(timeIntervalSince1970: date)
        return Date().timeIntervalSince1970 < date
        
    }
}
