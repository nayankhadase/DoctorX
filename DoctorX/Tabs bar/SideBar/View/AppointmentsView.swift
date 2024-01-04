//
//  AppointmentsView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 25/12/23.
//

import SwiftUI

struct AppointmentsView: View {
    @Environment(SideviewViewModel.self) var sideVM
    @Environment(HomeViewModel.self) var homeVM
    @State private var showHistory = false
    
    var body: some View {
        
        GeometryReader{ geo in
            ScrollView{
                VStack(spacing: 20){

                    VStack(alignment: .leading){
                        Text("Upcomming appointments")
                            .font(.body.bold())
                        
                        VStack(spacing: 20){
                            ForEach(sideVM.upcommingAppt, id: \.self){ apt in
                                NavigationLink {
                                    AppointmentDetailsView(appt: apt)
                                } label: {
                                    DrHistoryCardView(geo: geo, appointment: apt, homeVM: homeVM)
                                }
                                .buttonStyle(.plain)

                                
                            }
                        }
                    }
                    .padding(.bottom)
                    
                    
                    if showHistory {
                        VStack(alignment: .leading){
                            Text("History")
                                .font(.body.bold())
                            
                            VStack(spacing: 20){
                                ForEach(sideVM.historyAppt, id: \.self){ apt in
                                    NavigationLink {
                                        AppointmentDetailsView(appt: apt)
                                    } label: {
                                        DrHistoryCardView(geo: geo, appointment: apt, homeVM: homeVM)
                                    }
                                    .buttonStyle(.plain)
                                    
                                }
                            }
                        }
                    }
                    
                    Button {
                        withAnimation {
                            showHistory.toggle()
                        }
                    } label: {
                        Text(showHistory ? "Hide History" : "Show History")
                            .padding()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }
                    .background(
                        Capsule(style: .circular)
                            .fill(Color.accentColor)
                    )
                }
                .padding()
            }
        }
        .navigationTitle("Appointments")
    }
}

#Preview {
    AppointmentsView()
        .environment(SideviewViewModel())
        .environment(HomeViewModel())
}
