//
//  LoginViewModel.swift
//  DoctorX
//
//  Created by Nayan Khadase on 13/12/23.
//

import Foundation
import SwiftUI
import Observation

@Observable
class LoginViewModel{
    var email: String = ""
    var password: String = ""
    let networking = Networking.shared
    
    var isLogdIn = false
    var isLoading = false
    
    var showPassValidLabel = false
    var showEmailValidLabel = false
    
    var errorMessage = ""
    
    // to show alert
    var alertManager: AlertManager?
    var navigate: navigateType?
    var progressBar: ProgressbarViewModel?
    
    init(){
    }
    
    func tryLoging(){
        if let email = StoreData.loadFromStore(for: UDKey.userEmail) as? String, let pass = KeychainStore.retrieveCredentialsFromKeychain(username: email){
            print("logging...")
            self.email = email
            self.password = pass
            logIn()
        }
    }
    
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
    func logIn(){
        Task{
            await userLogin()
        }
        
    }
    
    private func userLogin() async {
        
        guard NetworkMonitor.shared.isConnected else{
            self.alertManager?.presentAlert(with: "Error", message: NSLocalizedString("Check network connection.", comment: "check_network_connection"))
            return
        }
        
        if isAuthInputValid{
            
            defer{
                progressBar?.hideProgressBar()
            }
            do {
                
                progressBar?.showProgressBar()
                
                let user = try await networking.loginUser(email: email, password: password)
                
                DispatchQueue.main.async {
                    self.isLogdIn = true
                }
                
                StoreData.saveToStore(data: email, for: UDKey.userEmail)
                if KeychainStore.saveCredentialsToKeychain(username: email, password: password){
                    print("store successfully")
                }else{
                    print("keystore data save failed")
                }
               
                email = ""
                password = ""
                
                User.shared.setuser(usr: user)
                
                
                self.navigate?(.push(.mainTabbar))
                
            } catch NetworkError.otherError(let msg) {
                print(msg)
                email = ""
                password = ""
                self.alertManager?.presentAlert(with: "Error", message: msg)
                
            } catch let error{
                print(error.localizedDescription)
                email = ""
                password = ""
                self.alertManager?.presentAlert(with: "Error", message: error.localizedDescription)
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
    
}
