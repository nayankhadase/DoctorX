//
//  DoctorInfoView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 03/06/23.
//

import SwiftUI

struct DoctorInfoView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack{
                ScrollView{
                    VStack(spacing: 20){
                        Image("dr")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.8, height: geo.size.width * 0.8)
                            .background(Color("Primary").opacity(0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack(spacing: 10){
                            Text("Dr. XYZ")
                                .font(.custom("PlayfairDisplay-Bold", size: 20))
                            
                            Text("Dentis | ")
                                .foregroundColor(Color("Primary"))
                            + Text("Patients attended: 400+")
                                .foregroundColor(Color("Primary"))
                            
                            HStack(spacing: 20){
                                Button {
                                    //code
                                } label: {
                                    Image(systemName: "phone")
                                        .padding(10)
                                        .background(LinearGradient(colors: [Color("Primary").opacity(0.7), Color("Primary")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .foregroundColor(.white)
                                        
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                
                                Button {
                                    //code
                                } label: {
                                    Image(systemName: "message")
                                        .padding(10)
                                        .background(LinearGradient(colors: [Color("Primary").opacity(0.7), Color("Primary")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .foregroundColor(.white)
                                        
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                
                                Button {
                                    //code
                                } label: {
                                    Image(systemName: "mappin.and.ellipse")
                                        .padding(10)
                                        .background(LinearGradient(colors: [Color("Primary").opacity(0.7), Color("Primary")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .foregroundColor(.white)
                                        
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 5))

                                
                                    
                            }
                            
                            VStack(spacing: 10){
                                HStack{
                                    Text("About")
                                        .font(.body.bold())
                                    Spacer()
                                    Label {
                                        Text("4.5")
                                    } icon: {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.orange)
                                            .imageScale(.small)
                                    }

                                }
                                Text("Create an app that helps doctors manage their clinics or practices efficiently. Include features like appointment scheduling, patient billing, staff management, and analytics for tracking key performance indicators.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .lineSpacing(5)
                            }
                            .padding()
                            
                            HStack(spacing: 10){
                                Button {
                                    //code
                                } label: {
                                    Text("Online consultation fee: 300/-")
                                        .padding(.vertical)
                                        .frame(maxWidth: .infinity)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color("Secondary"))
                                        )
                                        
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(alignment:.topTrailing) {
                                    Image(systemName: "checkmark")
                                        .imageScale(.small)
                                        .padding(4)
                                        .background(Color("Primary"))
                                        .clipShape(Circle())
                                        .foregroundColor(Color.white)
                                        .offset(x:3, y:-5)
                                }
//                                .frame(maxWidth: .infinity)
                                
                                Button {
                                    //code
                                } label: {
                                    Text("Clinic consultation fee: 200/-")
                                        .padding(.vertical)
                                        .frame(maxWidth: .infinity)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color("Primary"))
                                        )
                                        
                                }
                               
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 10)
                                )
//                                .frame(maxWidth: .infinity)

                            }
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.horizontal)
                            
                            HStack(spacing: 20){
                                Button {
                                    //code
                                } label: {
                                    Image(systemName: "heart")
                                        .imageScale(.large)
                                        .padding()
                                        
                                }
                                
                                Button {
                                    //code
                                } label: {
                                    Text("Book an apponintment")
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(LinearGradient(colors: [Color("Primary").opacity(0.7), Color("Primary")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .foregroundColor(Color.white)
                                }
                                
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .shadow(radius: 3, x:4, y:4)
                                


                            }
                            .padding()
                           
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            
        }
    }
}

struct DoctorInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorInfoView()
    }
}
