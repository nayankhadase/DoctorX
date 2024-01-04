//
//  LoginOptionsView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 10/12/23.
//

import SwiftUI

struct LoginOptionsView: View {
    @State private var loginViewModel = LoginViewModel()
    @Environment(AlertManager.self) var alertManager
    @Environment(\.navigate) var navigate
    @Environment(ProgressbarViewModel.self) var progressbarViewModel
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Color("Primary").opacity(0.2)
                    .ignoresSafeArea(edges: .all)
                
                SigninView(loginVM: loginViewModel, width: 500)
            }
        }
        .onTapGesture {
            dismissKeyboard()
        }
        .modifier(ProgressbarView(progressbarView: progressbarViewModel))
        .environment(loginViewModel)
        .onAppear(perform: {
            loginViewModel.alertManager = alertManager
            loginViewModel.navigate = navigate
            loginViewModel.progressBar = progressbarViewModel
            loginViewModel.tryLoging()
            
        })
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    LoginOptionsView()
        .environment(LoginViewModel())
        .environment(AlertManager())
        .environment(ProgressbarViewModel())
}

struct SigninView: View{
    @Environment(\.navigate) var navigate
    @Bindable var loginVM: LoginViewModel
    
    let width: CGFloat
    
    @State private var isSecure = true
    
    
    var body: some View{
        ZStack{
            ScrollView(.vertical){
                VStack(alignment: .center, spacing: 30){
                    Spacer()
                    Group{
                        Text("Hello Again!")
                            .font(.system(size: 40, design: .serif).bold())
                        
                        Text("welcome back we've\n been missed!")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 17, design: .serif))
                    }
                    
                    Spacer()
                    
                    Group{
                        VStack(alignment: .trailing, spacing: 3){
                            TextField("Enter email", text: $loginVM.email)
                                .padding()
                                .background()
                                .cornerRadius(10)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                                .onTapGesture {
                                    loginVM.hideValidationLabel()
                                }
                            if loginVM.showEmailValidLabel{
                                Text("Enter valid email ID.")
                                    .foregroundStyle(.red)
                            }
                        }
                        
                        
                        Group{
                            if isSecure{
                                VStack(alignment: .trailing, spacing: 3){
                                    SecureField("Enter Password", text: $loginVM.password)
                                        .padding()
                                        .background()
                                        .cornerRadius(10)
                                        .autocorrectionDisabled()
                                        .textInputAutocapitalization(.never)
                                        .overlay(alignment: .trailing) {
                                            Button {
                                                isSecure = false
                                            } label: {
                                                Image(systemName: "eye.slash")
                                                    .foregroundColor(.gray)
                                            }
                                            .padding(.horizontal, 7)
                                            .background()
                                        }
                                        .onTapGesture {
                                            loginVM.hideValidationLabel()
                                        }
                                    if loginVM.showPassValidLabel{
                                        Text("Password must be atleast 6 charactor.")
                                            .foregroundStyle(.red)
                                    }
                                }
                            }else{
                                VStack(alignment: .trailing, spacing: 3){
                                    TextField("Enter Password", text: $loginVM.password)
                                        .padding()
                                        .background()
                                        .autocorrectionDisabled()
                                        .textInputAutocapitalization(.never)
                                        .cornerRadius(10)
                                        .overlay(alignment: .trailing) {
                                            
                                            Button {
                                                isSecure = true
                                            } label: {
                                                Image(systemName: "eye")
                                                    .foregroundColor(.gray)
                                            }
                                            .padding(.horizontal, 7)
                                            .background()
                                        }
                                        .onTapGesture {
                                            loginVM.hideValidationLabel()
                                        }
                                    if loginVM.showPassValidLabel{
                                        Text("Password must be atleast 6 charactor.")
                                            .foregroundStyle(.red)
                                    }
                                }
                            }
                            
                            
                            
                        }
                    }
                    
                    HStack{
                        Spacer()
                        Button {
                            //code
                        } label: {
                            Text("forget password")
                                .font(.subheadline)
                            
                        }
                        
                    }
                    
                    
                    
                    Button {
                        loginVM.logIn()
                    } label: {
                        Text("Sign In")
                            .padding()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }
                    
                    .background(
                        Capsule(style: .circular)
                            .fill(Color.accentColor)
                    )
                    
                    HStack{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(LinearGradient(colors: [.green.opacity(0.3), .gray.opacity(0.9)], startPoint: .leading, endPoint: .trailing))
                            .frame(height: 2)
                        
                        Text("Or continue with")
                            .font(.subheadline)
                            .fixedSize()
                            .padding(.horizontal)
                        
                        RoundedRectangle(cornerRadius: 5)
                            .fill(LinearGradient(colors: [.green.opacity(0.3), .gray.opacity(0.9)], startPoint: .trailing, endPoint: .leading))
                            .frame(height: 2)
                    }
                    .padding(.horizontal)
                    
                    HStack(spacing: 20){
                        
                        OptionsView(iconName: "google")
                        OptionsView(iconName: "apple")
                        
                    }
                    
                    HStack{
                        Text("Not a member?")
                        Button {
//                            action()
                            navigate(.push(.registration))
                        } label: {
                            Text("Register now")
                        }
                        
                    }
                    .font(.caption)
                    
                    HStack{
                        Text("For doctor login / registration?")
                        Button {
                            //code
                        } label: {
                            Text("If you are a doctor")
                        }
                        
                    }
                    .font(.caption)
                    
                    
                    //                Spacer()
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        //        .background(.ultraThinMaterial)
    }
}


struct OptionsView: View {
    let iconName: String
    var body: some View {
        Button {
            //code
        } label: {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 20)
                .foregroundColor(.black)
                .padding()
                .padding(.horizontal)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white, lineWidth: 1.5)
        )
    }
}
