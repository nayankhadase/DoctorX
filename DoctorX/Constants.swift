//
//  Constants.swift
//  DoctorX
//
//  Created by Nayan Khadase on 10/12/23.
//

import Foundation

struct UDKey{
    static let doctorCategory = "DOCTOR_CATEGORY"
    static let userEmail = "EMAIL"
}



struct DummyData{
    static let doctor = Doctor(id: "dsfdffdfgdfgd", name: "Dr abc xyz", img: "dr", type: "general", phoneNumber: "", about: "Hello, I\'m Dr. Vishal, your virtual healthcare companion. My primary purpose is to assist and provide information on a wide range of medical topics. I don\'t have personal experiences, emotions, or physical presence, but I\'m here to offer support and answer your health-related questions to the best of my knowledge")
    
    static let appointment = Appointment(id: "dfsdfsdfsdf", userId: "sdfsfsf", doctor: DummyData.doctor, date: 1703836.0, consultationType: "Clinic")
    
    static let upcommingAppointment = Appointment(id: "dfsdfsdfsdf", userId: "sdfsfsf", doctor: DummyData.doctor, date: 1703581200.0, consultationType: "Clinic")
    
    
    static let appointments: [Appointment] = [
        DummyData.appointment,
        DummyData.appointment,
        DummyData.upcommingAppointment
    ]
    
    static let dummyMedicines: [MedicineModel] = [
        .init(id: "sdfsfsf", name: "name", category: "cat", price: "20", imagePath: "17043054624302.png", remainingItems: "5", offers: "0"),
        .init(id: "sdfsfsfsds", name: "other name", category: "cat", price: "10", imagePath: "17043054624302.png", remainingItems: "10", offers: "0"),
        .init(id: "sdfsfsdsf", name: "name other", category: "cat", price: "200", imagePath: "17043054624302.png", remainingItems: "15", offers: "0"),
        .init(id: "sdsdfsfsf", name: "name name", category: "cat", price: "2", imagePath: "17043054624302.png", remainingItems: "0", offers: "0")
    ]
}
