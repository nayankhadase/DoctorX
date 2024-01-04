//
//  SignupView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 20/12/23.
//

import SwiftUI

struct SignupView: View {
    @Environment(\.navigate) private var navigate
    @Environment(AlertManager.self) var alertManager
    @Environment(ProgressbarViewModel.self) var progressbarViewModel
    
    @State var signupViewModel = SignupViewModel()
    @State private var isSecure = true
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Color("Primary").opacity(0.2)
                    .ignoresSafeArea(edges: .all)
                
                ZStack{
                    ScrollView(.vertical){
                        VStack(alignment: .center, spacing: 30){
                            Spacer()
                            Group{
                                VStack{
                                    Text("Welcome!")
                                        .font(.system(size: 40, design: .serif).bold())
                                    
                                    Text("Let's create your profile")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 17, design: .serif))
                                    
                                    Image("checkup")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geo.size.width * 0.7)
                                }
                            }
                            
                            Spacer()
                            
                            Group{
                                VStack(alignment: .trailing, spacing: 3){
                                    TextField("Enter email", text: $signupViewModel.email)
                                        .padding()
                                        .background()
                                        .cornerRadius(10)
                                        .autocorrectionDisabled()
                                        .textInputAutocapitalization(.never)
                                        .onTapGesture {
                                            signupViewModel.hideValidationLabel()
                                        }
                                    if signupViewModel.showEmailValidLabel{
                                        Text("Enter valid email ID.")
                                            .foregroundStyle(.red)
                                    }
                                }
                                
                                
                                Group{
                                    if isSecure{
                                        VStack(alignment: .trailing, spacing: 3){
                                            SecureField("Enter Password", text: $signupViewModel.password)
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
                                                    signupViewModel.hideValidationLabel()
                                                }
                                            if signupViewModel.showPassValidLabel{
                                                Text("Password must be atleast 6 charactor.")
                                                    .foregroundStyle(.red)
                                            }
                                        }
                                    }else{
                                        VStack(alignment: .trailing, spacing: 3){
                                            TextField("Enter Password", text: $signupViewModel.password)
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
                                                    signupViewModel.hideValidationLabel()
                                                }
                                            if signupViewModel.showPassValidLabel{
                                                Text("Password must be atleast 6 charactor.")
                                                    .foregroundStyle(.red)
                                            }
                                        }
                                    }
                                    
                                    
                                    
                                }
                            }
                            
                            
                            Button {
                                signupViewModel.registerUser()
                            } label: {
                                Text("Register")
                                    .padding()
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                            }
                            .background(
                                Capsule(style: .circular)
                                    .fill(Color.accentColor)
                            )
                            
                            Button{
                                navigate(.push(.loginIn))
                            } label: {
                                Text("Already has account? SignIn")
                            }
                            
                            Spacer()
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    //                    .frame()
                }
                .padding()
                
            }
            .onTapGesture {
                dismissKeyboard()
            }
            .modifier(ProgressbarView(progressbarView: progressbarViewModel))
            
        }
        .onAppear(perform: {
            signupViewModel.navigate = navigate
            signupViewModel.alertManager = alertManager
            signupViewModel.progressBar = progressbarViewModel
            signupViewModel.signupViewModel = signupViewModel
        })
        .environment(signupViewModel)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SignupView()
        .environment(SignupViewModel())
}
