//
//  Extensons.swift
//  DoctorX
//
//  Created by Nayan Khadase on 07/05/23.
//

import SwiftUI


extension Color{
    static let offWhite = Color.init(red: 225/225, green: 225/225, blue: 235/225)
    
    static let darkStart = Color.init(red: 50/255, green: 60/255, blue: 65/255)
    static let darkEnd = Color.init(red: 25/255, green: 25/255, blue: 30/255)
}

public func dismissKeyboard() {
      UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
}
