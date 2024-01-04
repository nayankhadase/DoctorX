//
//  SignupViewModel.swift
//  DoctorX
//
//  Created by Nayan Khadase on 20/12/23.
//

import Foundation
import SwiftUI

@Observable
class SignupViewModel{
    
    //
    var navigate: navigateType?
    var alertManager: AlertManager?
    var signupViewModel: SignupViewModel?
    var progressBar: ProgressbarViewModel?
    //
    
    
    var email: String = ""
    var password: String = ""
    let networking = Networking.shared
    
    
    var isRegister = false
    var isLoading = false
    
    var showMainTabbar = false
    
    var showPassValidLabel = false
    var showEmailValidLabel = false
    
    //
    
    var name: String = ""
    let genderArray = ["male", "female"]
    var selectedGender = "male"
    
    var isValidEmail: Bool {
        withAnimation {
            Validation.isValidEmail(email: email)
        }
    }
    
    var isValidPassword: Bool {
        withAnimation {
            Validation.isValidPassword(pass: password)
        }
    }
    
    var isAuthInputValid: Bool{
        withAnimation {
            Validation.isAuthInputValid(email: email, password: password)
        }
    }
    
    func hideValidationLabel(){
        DispatchQueue.main.async {
            withAnimation {
                self.showPassValidLabel = false
                self.showEmailValidLabel = false
            }
        }
    }
    
    // sign in
    func registerUser(){
        Task{
            await registerUser()
        }
        
    }
    func registerNameAndGender(){
        Task{
            await setNameAndeGender()
        }
    }
    
    
    private func registerUser() async {
        
        
        if isAuthInputValid{
            
            defer{
                progressBar?.hideProgressBar()
            }
            do {
                progressBar?.showProgressBar()
                let user = try await networking.registerUser(email: email, password: password)
                
                User.shared.setuser(usr: user)
                
                if let _ = signupViewModel{
                    navigate?(.push(.genderSelection(signupViewModel!)))
                }
                
            } catch NetworkError.otherError(let msg) {
                print(msg)
                email = ""
                password = ""
                alertManager?.presentAlert(with: "Error", message: msg)
                
            } catch let error{
                print(error.localizedDescription)
                email = ""
                password = ""
                alertManager?.presentAlert(with: "Error", message: error.localizedDescription)
            }
        }else{
            DispatchQueue.main.async {
                withAnimation {
                    self.showEmailValidLabel = !self.isValidEmail
                    self.showPassValidLabel = !self.isValidPassword
                }
            }
        }
    }
    
    private func setNameAndeGender() async{
        defer{
            progressBar?.hideProgressBar()
        }
        do {
            progressBar?.showProgressBar()
             
            let params: [String: Any] = [
                "id": User.shared.userId as Any,
                "email": email,
                "password": password,
                "name": name,
                "gender": selectedGender
            ]
            
            let user = try await networking.updateUserDetails(params: params)
            
            User.shared.setuser(usr: user)
            
            if KeychainStore.saveCredentialsToKeychain(username: email, password: password){
                StoreData.saveToStore(data: email, for: UDKey.userEmail)
                print("store successfully")
            }else{
                print("keystore data save failed")
            }
            
            email = ""
            password = ""
            
            if let _ = signupViewModel{
                navigate?(.push(.mainTabbar))
            }
            
        } catch NetworkError.otherError(let msg) {
            print(msg)
            email = ""
            password = ""
            alertManager?.presentAlert(with: "Error", message: msg)
        } catch let error{
            print(error.localizedDescription)
            email = ""
            password = ""
            alertManager?.presentAlert(with: "Error", message: error.localizedDescription)
        }
    }
    
}
