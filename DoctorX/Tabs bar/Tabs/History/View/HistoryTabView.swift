//
//  HistoryTabView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 04/06/23.
//

import SwiftUI

struct HistoryTabView: View {
    @State private var searchText = ""
    @State private var historyViewModel = HistoryViewModel()
    @Environment(ProgressbarViewModel.self) var progressbarViewModel
    @Environment(HomeViewModel.self) var homeVM
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                VStack{
                    TopBarView(searchText: $searchText)
                        .padding(.horizontal)
                        .background()
                    ScrollView{
                        VStack(alignment: .leading, spacing: 0){
                        
                            DrCampCardView(geo: geo)
                            
                            Text("Appointment history")
                                .font(.body.bold())
                                .padding(.horizontal)
                            if historyViewModel.historyAppointments.isEmpty{
                                EmptyAppointmentView(message: "You don't have appointment history")
                            }else{
                                ScrollView{
                                    VStack{
                                        ForEach(historyViewModel.historyAppointments, id: \.self) { appointment in
                                            DrHistoryCardView(geo: geo, appointment: appointment, homeVM: homeVM)
                                        }
                                    }
                                    .padding()
                                }
                            }
                        }
                    }
                }
                
            }
            .frame(height: geo.size.height)
        }
        .modifier(ProgressbarView(progressbarView: progressbarViewModel))
        .onAppear(perform: {
            historyViewModel.progressBar = progressbarViewModel
            historyViewModel.fetchAllApponitments()
        })
    }
}

struct HistoryTabView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryTabView()
            .environment(HistoryViewModel())
            .environment(ProgressbarViewModel())
            .environment(HomeViewModel())
            .environment(MainTabbarViewModel())
           
    }
}

struct DrHistoryCardView: View {
    let geo: GeometryProxy
    let appointment: Appointment
    @Bindable var homeVM: HomeViewModel
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 5){
                    Text(appointment.doctor.name)
                        
                    Text(appointment.doctor.type)
                        .font(.caption)
                    
                    HStack(spacing: 0){
                        ForEach(1...5, id:\.self){ i in
                            Image(systemName: "star.fill")
                                .imageScale(.small)
                                .foregroundColor(.orange)
                            
                        }
                        Text("\(Int.random(in: 30..<200)) Reviews")
                            .font(.caption)
                            .padding(.leading, 4)
                    }
                }
                Spacer()
                Image("dr")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width * 0.2)
                    .background(Color("Primary"))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            HStack{
                Label {
                    Text(appointment.aptDate)
                        .font(.caption)
                } icon: {
                    Image(systemName: "calendar")
                }
                .foregroundColor(.secondary)
                
                Label {
                    Text(appointment.aptTime)
                        .font(.caption)
                } icon: {
                    Image(systemName: "clock")
                }
                .foregroundColor(.secondary)
                Spacer()
                
                if !appointment.isUpcomming{
                    Label {
                        Text("Visited")
                            .font(.caption)
                    } icon: {
                        Image(systemName: "circle.fill")
                            .imageScale(.small)
                            .foregroundColor(appointment.visited ? Color("Primary") : Color.red)
                    }
                    .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background()
            .clipShape(RoundedRectangle(cornerRadius: 5))
            
            if !appointment.isUpcomming{
                NavigationLink {
                    DoctorInfoView(homeVM: homeVM, doctor: appointment.doctor)
                } label: {
                    Text("Schedule again")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(Color("Primary"))
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .gray.opacity(0.3),radius: 5, x:3,y:3)
//        .padding(.bottom)
        
    }
}

struct DrCampCardView: View{
    let geo: GeometryProxy
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading, spacing: 5){
                    Text("Free body cheakup")
                        .font(.title3.bold())
                    Text("limited seats")
                        .font(.callout)
                    Text("book your seat")
                        .font(.caption)
                    
                    Button {
                        //code
                    } label: {
                        Text("Book now")
                            .padding(5)
                            .font(.caption)
                            .background()
                            .foregroundColor(Color("Primary"))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 5))

                }
                .foregroundColor(.white)
                
                Spacer()
                
                Image("checkup")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width * 0.4)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal)
        .background(LinearGradient(colors: [Color("Primary").opacity(0.7),Color("Primary")], startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 3, y:3)
        .shadow(color: Color.white.opacity(0.3), radius: 2, x: -3, y: -3)
        .padding()
    }
}

