//
//  DoctorInfoView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 03/06/23.
//

import SwiftUI

struct DoctorInfoView: View {
    
    @State private var isPlanSelected = 0
    let plans = ["Online consultation fee: 300/-", "Clinic consultation fee: 200/-"]
    @State private var showSheet = false
    @State private var showAlert = false
    
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
                                .font(.body.bold())
                            
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
                                ForEach(0...plans.count-1, id:\.self){ plan in
                                    ChargesView(isSelected: plan == isPlanSelected, text: plans[plan]){
                                        withAnimation {
                                            isPlanSelected = plan
                                        }
                                    }
                                }
                                
                                
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
                                    showSheet = true
                                    
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
            .sheet(isPresented: $showSheet) {
                AppointMentView(){
                    withAnimation{
                        showSheet = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                        showAlert = true
                    }
                }
                .presentationDetents([.medium, .large])
                
            }
            .alert("Booking", isPresented: $showAlert) {
                Button("Ok") {
                    showAlert.toggle()
                }
            } message: {
                Text("Your appointment has been booked!")
            }

            
        }
    }
}

struct DoctorInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorInfoView()
    }
}

struct AppointMentView: View{
    var onConfirm: () -> Void
    
    let availableTime = ["10.00\n AM", "12.00\n PM", "1.00\n PM", "3.00\n PM", "6.00\n PM"]
    @State private var isSelected = 0
    
    var body: some View{
        ZStack{
            VStack{
                HStack{
                    Text("Available time")
                    Spacer()
                }
                .padding()
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 10){
                        ForEach(0...availableTime.count - 1, id:\.self) { time in
                            AvalTimeView(isActive: time == isSelected, time: availableTime[time]) {
                                isSelected = time
                            }
                        }
                    }
                }
                .padding(.leading)
                
                Button {
                    onConfirm()
                } label: {
                    Text("Confirm")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(colors: [Color("Primary").opacity(0.7), Color("Primary")], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .foregroundColor(Color.white)
                }
                
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 3, x:4, y:4)
                .padding()

                
                Spacer()
            }
        }
    }
}


struct ChargesView: View {
    var isSelected: Bool
    let text: String
    var action: () -> Void
    
    var body: some View {
        if isSelected{
            Button {
                action()
            } label: {
                Text(text)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("Secondary"))
                    )
                    .foregroundColor(.primary)
                    .font(.system(size: 15))
                
            }
            .overlay(content: {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("Primary"))
            })
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(alignment:.topTrailing) {
                Image(systemName: "checkmark")
                    .imageScale(.small)
                    .padding(4)
                    .background(Color("Primary"))
                    .clipShape(Circle())
                    .foregroundColor(Color.white)
                    .offset(x:3, y:-5)
                    .shadow(radius: 1, x:1, y:1)
                    
            }
        } else{
            Button {
                action()
            } label: {
                Text(text)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("Primary"))
                    )
                    .font(.system(size: 15))
                
            }
            
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
        }
    }
}


struct AvalTimeView: View{
    let isActive: Bool
    let time: String
    let action: (() -> Void)
    
    var body: some View{
        Button {
            action()
            
        } label: {
            VStack{
                Text(time)
                    .padding()
                    .foregroundColor(isActive ? .white : Color("Primary"))
                    .background(isActive ? Color("Primary") : Color("Secondary"))
                    .clipShape(Circle())
                
            }
        }
    }
}
