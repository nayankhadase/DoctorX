//
//  UserDataView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 13/12/23.
//

import SwiftUI

struct GenderSelectionView: View {
    @Environment(SignupViewModel.self) var signupViewModel
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Color("Primary").opacity(0.2)
                    .ignoresSafeArea(edges: .all)
                
                InputDetailsView(signupViewModel: signupViewModel, geo: geo)
            }
            .navigationBarBackButtonHidden()
        }
        .onTapGesture {
            dismissKeyboard()
        }
    }
}

#Preview {
    GenderSelectionView()
        .environment(SignupViewModel())
}

struct InputDetailsView: View {
    @Bindable var signupViewModel: SignupViewModel
    let geo: GeometryProxy
    
    var body: some View {
        VStack(alignment:.leading){
            Spacer()
            Text("Hello there!")
                .font(.system(size: 40, design: .serif).bold())
            
            Text("What we call you?")
                .padding(.bottom)
            
            
            TextField("Enter Name", text: $signupViewModel.name)
                .padding()
                .background()
                .cornerRadius(10)
                .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 20){
                Text("Select gender")
                
                HStack(spacing: 30){
                    
                    ForEach(signupViewModel.genderArray, id:\.self){ gender in
                        GenderCardView(geo: geo, gender: gender, isSelected: signupViewModel.selectedGender == gender) {
                            withAnimation {
                                signupViewModel.selectedGender = gender
                            }
                        }
                    }
                    
                    
                }
                .frame(maxWidth: .infinity)
            }
            Spacer()
            
            Button {
                //code
                signupViewModel.registerNameAndGender()
            } label: {
                HStack{
                    Text("Let's go")
                    Image(systemName: "arrow.right")
                }
                .padding()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
            }
            .background(
                Capsule(style: .circular)
                    .fill(Color.accentColor)
            )
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct GenderCardView: View {
    let geo: GeometryProxy
    let gender: String
    let isSelected: Bool
    let action: (() -> Void)
    var body: some View {
        VStack{
            Image(gender.lowercased())
                .resizable()
                .scaledToFit()
                .frame(width: geo.size.width * 0.4)
            
            Text(gender.capitalized)
                .font(.headline.bold())
                .padding(.bottom)
                .foregroundStyle( isSelected ? Color.white : Color.secondary)
        }
        .background(isSelected ? Color("Primary").opacity(0.4) : Color("Secondary"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 3, y: 3)
        .overlay(alignment:.topTrailing) {
            if isSelected{
                Image(systemName: "checkmark")
                    .imageScale(.small)
                    .padding(5)
                    .background(Color("Primary"))
                    .clipShape(Circle())
                    .foregroundColor(Color.white)
                    .offset(x:3, y:-5)
                    .shadow(radius: 1, x:1, y:1)
            }
            
        }
        .onTapGesture {
            action()
        }
    }
}
