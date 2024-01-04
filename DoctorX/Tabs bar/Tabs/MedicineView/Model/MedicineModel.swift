//
//  MedicineModel.swift
//  DoctorX
//
//  Created by Nayan Khadase on 03/01/24.
//

import Foundation

struct MedicineModel: Codable, Hashable{
    let id: String
    let name: String
    let category: String
    let price: String
    let imagePath: String
    let remainingItems: String
    let offers: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, category, price, imagePath, remainingItems, offers
    }
    
    var actualimagePath: String{
        return ServerDetails.publicImage + imagePath
    }
    
    var priceValue: Double{
        return Double(price) ?? 0.0
    }
    
    var remainingItemValue: Int{
        return Int(remainingItems) ?? 0
    }
}
