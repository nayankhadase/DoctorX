//
//  HomeView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 07/05/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var searchText = ""
    @State private var categoryIndex: Int = 0
    
    @Environment(MainTabbarViewModel.self) var mainTabbarVM
    @Environment(HomeViewModel.self) var homeVM
    @Environment(ProgressbarViewModel.self) var progressbarViewModel
    
    
    var body: some View {
        ZStack{
            GeometryReader{ geo in
                VStack(alignment: .leading){
                    TopBarView(searchText: $searchText)
                        .padding(.horizontal)
                        .background()
                        .shadow(color: Color.gray.opacity(0.2), radius: 3, x: 1.5, y: 1.5)
                    
                    
                    ScrollView(.vertical){
                        VStack(alignment: .leading){
                            if (User.shared.name != nil){
                                VStack(alignment: .leading){
                                    Text("Hey!")
                                    Text(User.shared.name?.split(separator: " ").first ?? "")
                                        .font(.system(size: 25, design: .serif).bold())
                                }
                                .padding(.horizontal)
                                .padding(.bottom, 8)
                            }
                            
                            VStack(alignment: .leading, spacing: 0){
                                HStack{
                                    Text("Upcomming Appointments")
                                        .font(.system(.subheadline))
                                        .foregroundColor(.black.opacity(0.6))
                                    
                                    Spacer()
                                    if !homeVM.upcommingAppointments.isEmpty{
                                        Button {
                                            //code
                                        } label: {
                                            Text("View all")
                                                .font(.caption)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                
                                if !homeVM.upcommingAppointments.isEmpty{
                                    UpcommingAppointmentView()
                                }else{
                                    EmptyAppointmentView(message: "No upcomming appointment available")
                                }
                            }
                            
                            // category
                            VStack(alignment: .leading, spacing: 0){
                                Text("Categories")
                                    .font(.system(.subheadline))
                                    .foregroundColor(.black.opacity(0.6))
                                    .padding(.horizontal)
                                
                                AllCategoryView(categoryIndex: $categoryIndex)
                            }
                            
                            // top doctors
                            VStack(alignment: .leading, spacing: 0){
                                Text("Top Rated Doctors")
                                    .font(.system(.subheadline))
                                    .foregroundColor(.black.opacity(0.6))
                                    .padding(.horizontal)
                                if !homeVM.doctors.isEmpty{
                                    TopRatedDoctorView()
                                }else{
                                    Text("No doctors available")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color("Secondary").opacity(0.5))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .padding()
                                }
                            }
                        }
                    }
                    .redacted(reason: homeVM.isLoading ? .placeholder : .init())
                    Spacer()
                }
            }
        }
        .modifier(ProgressbarView(progressbarView: progressbarViewModel))
    }
}

struct TopBarView: View{
    @Binding var searchText: String
    @Environment(MainTabbarViewModel.self) private var mainTabBarVM
    
    var body: some View{
        HStack(spacing: 20){
            
            Button {
                if mainTabBarVM.showHamburger{
                    // open sidebar
                    withAnimation {
                        mainTabBarVM.isSideMenuOpen = true
                    }
                    
                }else{
                    // open notification
                }
            } label: {
                Image(systemName: mainTabBarVM.showHamburger ? "list.bullet" : "bell")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 15)
            }
            
            
            HStack(spacing: 0){
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .padding(.leading)
                    .foregroundColor(Color("Primary").opacity(0.5))
                
                TextField("Search..", text: $searchText)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                
                
            }
            .background(.gray.opacity(0.05))
            .clipShape(Capsule())
            .overlay(content: {
                Capsule()
                    .stroke(.gray.opacity(0.5),lineWidth: 1)
            })
            .padding(.vertical, 7)
            
            
            
            
            
            Button {
                //code
            } label: {
                Image(systemName: "cart")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
            }
        }
    }
}

struct EmptyAppointmentView: View {
    let message: String
    var body: some View {
        VStack(spacing: 10){
            HStack{
                VStack{
                    Text("Oops!\n\(message)")
                        .foregroundStyle(Color.white.opacity(0.5))
                }
                Spacer()
                Image("checkup")
                    .resizable()
                    .scaledToFit()
                    .frame(height:150)
            }
            
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .padding()
        .background(LinearGradient(colors: [Color("Primary").opacity(0.7),Color("Primary")], startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 3, y:3)
        .shadow(color: Color.white.opacity(0.3), radius: 2, x: -3, y: -3)
        .padding()
    }
}

struct UpcommingAppointmentView: View{
    @Environment(HomeViewModel.self) private var homeViewModel
    
    var body: some View{
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(homeViewModel.upcommingAppointments, id: \.id) { appointment in
                    NavigationLink {
                        AppointmentDetailsView(appt: appointment)
                    } label: {
                        AppointmentCardView(appointment: appointment)
                    }

                    
                        
                }
            }
        }
        
    }
}

struct AppointmentCardView: View{
    let appointment: Appointment
    
    var body: some View{
        VStack{
            HStack{
                Image("dr")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                VStack(alignment: .leading){
                    Text(appointment.doctor.name)
                        .font(.body)
                        .foregroundColor(.white)
                    
                    Text(appointment.doctor.type.capitalized)
                        .font(.caption2)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Button {
                    //code
                } label: {
                    Image(systemName: "phone.and.waveform")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .foregroundColor(Color("Primary"))
                        .padding(8)
                }
                
                .background(Color.offWhite)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 2, y:2)
                .shadow(color: Color.white.opacity(0.7), radius: 2, x: -1, y: -1)
                .padding(.leading)
                
            }
            
            HStack{
                Label {
                    Text(appointment.aptDate)
                        .font(.caption)
                } icon: {
                    Image(systemName: "calendar")
                }
                .foregroundColor(.secondary)
                
                Spacer()
                
                Label {
                    Text(appointment.aptTime)
                        .font(.caption)
                } icon: {
                    Image(systemName: "clock")
                }
                .foregroundColor(.secondary)
            }
            .padding(5)
            .padding(.horizontal)
            .background()
            .clipShape(RoundedRectangle(cornerRadius: 5))
        }
        .padding()
        .frame(width: UIScreen.main.bounds.size.width * 0.85)
        .background(LinearGradient(colors: [Color("Primary").opacity(0.7),Color("Primary")], startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 3, y:3)
        .shadow(color: Color.white.opacity(0.3), radius: 2, x: -3, y: -3)
        .padding(10)
        
    }
}

struct AllCategoryView: View{
    @Environment(HomeViewModel.self) var homeVM
    @Binding var categoryIndex: Int
    
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment: .center, spacing: 0){
                ForEach(homeVM.doctorCategory, id: \.self) { category in
                    CategoryCardView(isActive: category == homeVM.doctorCategory[categoryIndex], drType: category){
                        //code
                        withAnimation {
                            categoryIndex = homeVM.doctorCategory.firstIndex(of: category) ?? 0
                        }
                        homeVM.getFilterDoctors(type: category.type)
                        
                    }
                }
            }
        }
    }
}

struct CategoryCardView: View{
    let isActive: Bool
    let drType: DrCategory
    let action: (() -> Void)
    
    @Namespace var namespace
    var body: some View{
        Button {
            action()
            
        } label: {
            VStack{
                Image("general")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .padding()
                    .foregroundColor(isActive ? .white : Color("Primary"))
                    .background(isActive ? Color("Primary") : .offWhite)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 2, y: 2)
                    .shadow(color: Color.white.opacity(0.7), radius: 5, x: -3, y: -3)
                
                Text(drType.type.capitalized)
                    .font(.caption)
            }
            
        }
        .padding()
        
        
        
    }
}

struct TopRatedDoctorView: View{
    @Environment(HomeViewModel.self) var homeVM
    
    var body: some View{
        
        ScrollView(.vertical){
            VStack{
                ForEach(homeVM.doctors, id: \.self){ doctor in
                    NavigationLink {
                        DoctorInfoView(homeVM: homeVM, doctor: doctor)
                    } label: {
                        TopRatedDoctorCardView(doctor: doctor)
                    }
                    
                    
                }
            }
            .padding()
        }
        
        
    }
}

struct TopRatedDoctorCardView: View {
    @State private var isFavorite = false
    //    var drType: String
    let doctor: Doctor
    
    var body: some View {
        HStack(alignment: .top, spacing: 20){
            VStack{
                Spacer()
                Image("dr")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .background(Color("Primary").opacity(0.5))
                    .clipShape(Circle())
                Spacer()
            }
            
            
            VStack(alignment: .leading, spacing: 5){
                Spacer()
                Text(doctor.name.capitalized)
                    .font(.body)
                
                HStack(alignment: .center, spacing: 15){
                    Text(doctor.type.capitalized)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack{
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10)
                            .foregroundColor(.orange)
                        
                        Text("4.5")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                    }
                }
                Spacer()
            }
            
            Spacer()
            
            Button {
                isFavorite.toggle()
            } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundColor(isFavorite ? .red : .secondary)
            }
            .padding([ .top], 7)
            
            
            
            
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
        .background(Color("Secondary").opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.vertical, 4)
    }
}




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(MainTabbarViewModel())
            .environment(HomeViewModel())
            .environment(ProgressbarViewModel())
    }
}
