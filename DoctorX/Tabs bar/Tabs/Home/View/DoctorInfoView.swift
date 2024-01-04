//
//  DoctorInfoView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 03/06/23.
//

import SwiftUI
import MapKit

struct DoctorInfoView: View {
    //    @Environment(HomeViewModel.self) var homeVM
    @Bindable var homeVM: HomeViewModel
    @State private var selectedPlan = 0
    let plans = [
        [
            "type": "Online",
            "charges": "300"
        ],
        [
            "type": "Clinic",
            "charges": "200"
        ]
    ]
    @State private var showSheet = false
    @State private var showAlert = false
    
    let doctor: Doctor
    
    @State private var date = Date()
    let home = CLLocationCoordinate2DMake(18.520490, 73.856743)
    func openMapApp(coordinate: CLLocationCoordinate2D){
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Destination"
        MKMapItem.openMaps(with: [mapItem], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack(){
                ScrollView{
                    VStack(spacing: 20){
                        Image("dr")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.8, height: geo.size.width * 0.8)
                            .background(Color("Primary").opacity(0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack(spacing: 10){
                            Text(doctor.name.capitalized)
                                .font(.body.bold())
                            
                            Text("\(doctor.type.capitalized) | ")
                                .foregroundColor(Color("Primary"))
                            + Text("Patients attended: 400+")
                                .foregroundColor(Color("Primary"))
                            
                            HStack(spacing: 20){
                                Link(destination: URL(string: "tel://9158695111")!, label: {
                                    Image(systemName: "phone")
                                        .padding(10)
                                        .background(LinearGradient(colors: [Color("Primary").opacity(0.7), Color("Primary")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .foregroundColor(.white)
                                    
                                })
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                
                                Link(destination: URL(string: "sms:+931234567890&body=Hello \(doctor.name), \nI'm feeling lazy.")!, label: {
                                    Image(systemName: "message")
                                        .padding(10)
                                        .background(LinearGradient(colors: [Color("Primary").opacity(0.7), Color("Primary")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .foregroundColor(.white)
                                    
                                })
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                
                                Button {
                                    openMapApp(coordinate: home)
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
                                Text(doctor.about)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .lineSpacing(5)
                            }
                            .padding()
                            
                            VStack(alignment: .leading){
                                Text("Consultation type")
                                    .font(.body.bold())
                                
                                HStack(spacing: 10){
                                    
                                    ForEach(0...plans.count-1, id:\.self){ plan in
                                        ChargesView(isSelected: plan == selectedPlan, plan: plans[plan]){
                                            withAnimation {
                                                selectedPlan = plan
                                            }
                                        }
                                    }
                                }
                                .fixedSize(horizontal: false, vertical: true)
                            }
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
                AppointMentView(date: $date, type: plans[selectedPlan]["type"] ?? "clinic"){
                    withAnimation{
                        showSheet = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                        showAlert = true
                    }
                    
                    homeVM.bookAppointment(drId: doctor.id, date: date, type: plans[selectedPlan]["type"] ?? "clinic")
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
        DoctorInfoView(homeVM: HomeViewModel(), doctor: Doctor(id: "sdfsfsfs", name: "Dr. ABC", img: "", type: "General", phoneNumber: "4654646464", about: "dsfsfsdf dsf fsdf sdf sdfsasfsdf fds fsd fsdf sfs f fsfsf  fsfsfs   fsfsfsfsfsf   fsfsfsf  fsfs   fsfsfs   sfsfsf   fsfsf   fsfsfsfsfsfsfsf  fsfsfsfsfsfsf \n sf \n fssfsf\n fsdfsf \n ewfrwerwrwr \n rewrwerwe \n serfrwesrfwerf \n sfrtete \nefrwerwre \n"))
    }
}

struct AppointMentView: View{
    @Binding var date: Date
    var type: String
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents(in: .current, from: Date())
        let endComponents = calendar.dateComponents(in: .current, from: Date(timeIntervalSinceNow: TimeInterval(24*60*60*4)))
        return calendar.date(from:startComponents)!
        ...
        calendar.date(from:endComponents)!
    }()
    
    let timeRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents(in: .current, from: Date())
        
        let endComponents = calendar.dateComponents(in: .current, from: Date(timeIntervalSinceNow: TimeInterval(24*60*60*4)))
        return calendar.date(from:startComponents)!
        ...
        calendar.date(from:endComponents)!
    }()
    
    
    @State private var isSelected = 0
    
    var onConfirm: () -> Void
    
    var body: some View{
        ZStack{
            VStack{
                Text("Book Appointment")
                    .font(.system(size: 25)).bold()
                    .padding(.top, 40)
                
                Divider()
                
                HStack{
                    Text("Selected type")
                    Spacer()
                    Text(type)
                        .padding(5)
                        .padding(.horizontal, 10)
                        .foregroundStyle(.secondary)
                        .background(Color("Secondary").opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding()
                
                DatePicker("Select date", selection: $date, in: dateRange, displayedComponents: [.date])
                    .padding()
                
                //                HStack{
                //                    Text("Available time:")
                //                    Spacer()
                //                }
                //                .padding()
                
                DatePicker("Select Time", selection: $date, in: timeRange, displayedComponents: [.hourAndMinute])
                
                    .padding()
                
                //                ScrollView(.horizontal, showsIndicators: false){
                //                    HStack(spacing: 10){
                //                        ForEach(0...availableTime.count - 1, id:\.self) { time in
                //                            AvalTimeView(isActive: time == isSelected, time: availableTime[time]) {
                //                                isSelected = time
                //                            }
                //                        }
                //                    }
                //                }
                //                .padding(.leading)
                
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
                
                Text("\(date) via/to \(type)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Spacer()
            }
        }
        .onAppear(perform: {
            UIDatePicker.appearance().minuteInterval = 30
            
        })
    }
}


struct ChargesView: View {
    var isSelected: Bool
    let plan: [String: String]
    var action: () -> Void
    
    var body: some View {
        if isSelected{
            Button {
                action()
            } label: {
                VStack{
                    Text(plan["type"] ?? "")
                        .bold()
                    Text("Charges: ₹\(plan["charges"] ?? "")")
                        .foregroundStyle(.secondary)
                }
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
                VStack{
                    Text(plan["type"] ?? "")
                        .bold()
                    Text("Charges: ₹\(plan["charges"] ?? "")")
                        .foregroundStyle(.secondary)
                }
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
