//
//  HomeView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 07/05/23.
//

import SwiftUI

struct DrCategory: Hashable{
    let type: String
    let imgname: String
}

struct HomeView: View {
    @State private var searchText = ""
    @State private var categoryIndex: Int = 0
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 30){
                TopBarView(searchText: $searchText)
                    .padding(.horizontal)
                    .background()
                //.shadow(color: Color.black.opacity(0.2), radius: 5, x: 3, y: 3)
                
                ScrollView(.vertical){
                    VStack{
                        VStack(alignment: .leading, spacing: 0){
                            HStack{
                                Text("Upcomming Appointments")
                                    .font(.system(.subheadline))
                                    .foregroundColor(.black.opacity(0.6))
                                
                                Spacer()
                                Button {
                                    //code
                                } label: {
                                    Text("View all")
                                        .font(.caption)
                                }

                            }
                            .padding(.horizontal)
                            UpcommingAppointmentView()
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
                            TopRatedDoctorView()
                        }
                    }
                }
                
                
                
                
                
                Spacer()
            }
        }
    }
}

struct TopBarView: View{
    @Binding var searchText: String
    var body: some View{
        HStack(spacing: 20){
            Button {
                //code
            } label: {
                Image(systemName: "bell")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
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

struct UpcommingAppointmentView: View{
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(0...4, id: \.self) { index in
                    AppointmentCardView()
                }
            }
        }
    }
}

struct AppointmentCardView: View{
    
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
                    Text("Dr. Name")
                        .font(.body)
                        .foregroundColor(.white)
                    
                    Text("Dentist")
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

                
            }
            
            HStack{
                Label {
                    Text("22-05-2023")
                        .font(.caption)
                } icon: {
                    Image(systemName: "calendar")
                }
                .foregroundColor(.secondary)
                
                Spacer()
                
                Label {
                    Text("11.00 Am - 12.00 Pm")
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
        .background(Color("Primary"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.2), radius: 7, x: 3, y:3)
        .shadow(color: Color.white.opacity(0.7), radius: 7, x: -3, y: -3)
        .padding()
        
    }
}

struct AllCategoryView: View{
    @Binding var categoryIndex: Int
    @State private var categories: [DrCategory] = [
        .init(type: "General", imgname: ""),
        .init(type: "Pediatrician", imgname: ""),
        .init(type: "Cardiologist", imgname: ""),
        .init(type: "Dermatologist", imgname: ""),
        .init(type: "Neurologist", imgname: ""),
        .init(type: "Psychiatrist", imgname: ""),
    ]
    
    
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment: .center){
                ForEach(categories, id: \.self) { category in
                    CategoryCardView(isActive: category == categories[categoryIndex], drType: category){
                        //code
                        withAnimation {
                            categoryIndex = categories.firstIndex(of: category) ?? 0
                        }
                        
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
                
                Text(drType.type)
                    .font(.caption)
            }
            
        }
        .padding()

        

    }
}

struct TopRatedDoctorView: View{
    var body: some View{
        ScrollView(.vertical){
            VStack{
                ForEach(0...5, id: \.self){ index in
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
                            Text("Dr. Name")
                                .font(.body)
                            
                            HStack(alignment: .center, spacing: 15){
                                Text("Dentist")
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
                            //code
                        } label: {
                            Image(systemName: "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .foregroundColor(.secondary)
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
            .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
