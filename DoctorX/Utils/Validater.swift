//
//  Validater.swift
//  DoctorX
//
//  Created by Nayan Khadase on 19/12/23.
//

import Foundation


class Validation: NSObject{
    private static let passwordRegex = "^.{6,}$"
    private static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    
    static func isValidEmail(email: String) -> Bool {
        let passPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return passPredicate.evaluate(with: email)

    }
    
    static func isValidPassword(pass: String) -> Bool {
        let passPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passPredicate.evaluate(with: pass)
    }
    
    static func isAuthInputValid(email: String, password: String) -> Bool{
        Validation.isValidEmail(email: email) && Validation.isValidPassword(pass: password)
    }
    
    static func isValidName(name: String) -> Bool{
        name.count >= 2
    }
}
