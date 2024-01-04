//
//  AlertManager.swift
//  DoctorX
//
//  Created by Nayan Khadase on 24/12/23.
//

import SwiftUI
import Observation

@Observable
class AlertManager{
    var isPresented = false
    var title = ""
    var message = ""
    
    func presentAlert(with title: String, message: String){
        DispatchQueue.main.async {
            self.title = title
            self.message = message
            self.isPresented = true
        }
    }
}
