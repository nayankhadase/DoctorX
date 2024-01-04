//
//  ErrorHandler.swift
//  DoctorX
//
//  Created by Nayan Khadase on 24/12/23.
//

import Foundation


// error
struct ErrorResponse: Decodable {
    let error: String
    let errorCode: String?
}

struct ErrorConstants{
    static let user_not_found = "user_not_found"
    static let email_already_exists = "email_already_exists"
}

final class ErrorHandler{
    class func handleError(data: Data?, response: URLResponse?) throws {
        // Check for specific error codes and messages
        if let httpResponse = response as? HTTPURLResponse,
           httpResponse.statusCode == 400,
           let errorData = data,
           let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: errorData) {
            if let errorCode = errorResponse.errorCode{
                throw NetworkError.otherError(getLocalizedErrorMessage(errorCode: errorCode))
            }else{
                throw NetworkError.otherError(errorResponse.error)
            }
        } else {
            // Handle other errors
            throw NetworkError.unknown
        }
    }
    
    
    class func getLocalizedErrorMessage(errorCode: String) -> String{
        if errorCode == ErrorConstants.email_already_exists{
            return NSLocalizedString("Email already exists.", comment: "email_already_exists")
        }else if errorCode == ErrorConstants.user_not_found{
            return NSLocalizedString("Invalid login credentials.", comment: "user_not_found")
        }
        
        return NSLocalizedString("server_error", comment: "Server error.")
    }
    
    
}
