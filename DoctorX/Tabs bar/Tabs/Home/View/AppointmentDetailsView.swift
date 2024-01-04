//
//  AppointmentDetailsView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 26/12/23.
//

import SwiftUI

struct AppointmentDetailsView: View {
    let appt: Appointment
    var body: some View {
        ZStack{
            GeometryReader{ geo in
                VStack(alignment: .center){
                    VStack{
                        Image("dr")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.6, alignment: .center)
                        
                        Text(appt.doctor.name)
                            .font(.title.bold())
                        
                        Text(appt.doctor.type)
                        
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
                    }
                    .padding(.bottom)
                    
                    Divider()
                    
                    VStack(alignment: .leading){
                        Text("Appointment details")
                            .foregroundStyle(.secondary)
                        
                        HStack{
                            
                            Text("Date:")
                            Spacer()
                            Label {
                                Text(appt.aptDate)
    //                                .font(.caption)
                            } icon: {
                                Image(systemName: "calendar")
                            }
                            
                        }
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("Secondary"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        
                        HStack{
                            
                            Text("Time:")
                            Spacer()
                            Label {
                                Text(appt.aptTime)
    //                                .font(.caption)
                            } icon: {
                                Image(systemName: "clock")
                            }
                            
                        }
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("Secondary"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        
                        HStack{
                            
                            Text("Type:")
                            Spacer()
                            Label {
                                Text(appt.consultationType)
    //                                .font(.caption)
                            } icon: {
                                Image(systemName: "location")
                            }
                            
                        }
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("Secondary"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        
                        
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    VStack{
                        if appt.isUpcomming{
                            HStack{
                                Button(action: {
                                    
                                }, label: {
                                    Text("Cancel")
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                })
                                
                                .background(Color.red)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                Button(action: {
                                    
                                }, label: {
                                    Text("Modify")
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                })
                                
                                .background(Color("Primary"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .foregroundStyle(.white)
                        }else{
                            HStack{
                                Button(action: {
                                    
                                }, label: {
                                    Text("Book again")
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                })
                                
                                .background(Color("Primary"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                            }
                            .foregroundStyle(.white)
                        }
                        
                    }
                    .padding()
                    
                }
                .frame(maxWidth: .infinity)
                
            }
        }
    }
}

#Preview {
    AppointmentDetailsView(appt: DummyData.appointment)
}
