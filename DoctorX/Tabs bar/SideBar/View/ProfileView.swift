//
//  ProfileView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 25/12/23.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @Environment(SideviewViewModel.self) var sideviewVM
    @State private var image: KFImage?
    init() {
//        if let urlstr = User.shared.profileImagePath, let url = URL(string: urlstr){
           
                image = KFImage(URL(string: "http://192.168.1.11:3000/public/1704221438526image.jpg"))
            
//        }
    }
    
    var body: some View {
        ZStack{
            GeometryReader{ geo in
                ScrollView{
                    VStack(alignment: .leading){
                        VStack(alignment:.center){
                            if image != nil{
                                image?
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geo.size.width * 0.4, height:geo.size.width * 0.4, alignment: .center)
                                    .background()
                                    .clipShape(Circle())
                                    .shadow(color: .gray.opacity(0.4), radius: 5)
                                    .overlay(alignment: .topTrailing, content: {
                                        NavigationLink(destination: {
                                            EditProfileImage(selectedImage: $image)
                                                .environment(sideviewVM)
                                        }, label: {
                                            Image(systemName: "pencil")
                                                .foregroundStyle(.black)
                                                .padding(5)
                                        })
                                        .background()
                                        .clipShape(Circle())
                                        .shadow(color: .gray.opacity(0.4), radius: 5)
                                        .offset(x:-10, y:10)
                                    })
                            }else{
                                Image("dr")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geo.size.width * 0.4, height:geo.size.width * 0.4, alignment: .center)
                                    .background()
                                    .clipShape(Circle())
                                    .shadow(color: .gray.opacity(0.4), radius: 5)
                                    .overlay(alignment: .topTrailing, content: {
                                        NavigationLink(destination: {
                                            EditProfileImage(selectedImage: $image)
                                                .environment(sideviewVM)
                                        }, label: {
                                            Image(systemName: "pencil")
                                                .foregroundStyle(.black)
                                                .padding(5)
                                        })
                                        .background()
                                        .clipShape(Circle())
                                        .shadow(color: .gray.opacity(0.4), radius: 5)
                                        .offset(x:-10, y:10)
                                    })
                            }
                            
                            Text(User.shared.name?.capitalized ?? "")
                                .foregroundStyle(.white)
                                .font(.title.bold())
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("Primary"))
                        
        
                        
                        VStack(alignment: .leading){
                            VStack(alignment: .leading){
                                Text("Email")
                                    .foregroundStyle(.tertiary)
                                Text("nayan@gmail.com")
                                Divider()
                            }
                            
                            VStack(alignment: .leading){
                                Text("Phone number")
                                    .foregroundStyle(.tertiary)
                                Text("+91" + "9439867282")
                                Divider()
                            }
                            
                            VStack(alignment: .leading){
                                Text("Address")
                                    .foregroundStyle(.tertiary)
                                Text("Sumasoft pvt. ltd., Aundh, Pune 43007")
                                Divider()
                            }
                            
                           
//                            HStack{
//                                Label(
//                                    title: {
//                                        Text("9195940399")
//                                            .padding(.vertical)
//                                    },
//                                    icon: {
//                                        Image(systemName: "phone")
//                                    }
//                                )
//                            }
//                            .frame(maxWidth: .infinity)
//                            .padding(.horizontal,10)
//                            .background(Color("Secondary"))
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                            .padding(.horizontal)
                            
                        }
                        .padding(.horizontal)
                        .padding(.vertical)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                }
                
            }
        }
        .onAppear{
            guard let urlstr = User.shared.profileImagePath, let url = URL(string: urlstr)else {return}
                image = KFImage(url)
        }
        
    }
}

#Preview {
    ProfileView()
        .environment(SideviewViewModel())
}
