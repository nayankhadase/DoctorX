//
//  SideView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 10/12/23.
//

import SwiftUI

struct SideView: View {
    @Environment(MainTabbarViewModel.self) var mainTabbarVM
    @Environment(\.navigate) var navigate
    @State private var sideViewModel = SideviewViewModel()
    @Environment(HomeViewModel.self) var homeVM
    
    var width: CGFloat = 0
    
    var body: some View{
        ZStack(alignment: .topLeading){
            //dimmed background view
            GeometryReader { _ in
                EmptyView()
            }
            .background(.gray.opacity(0.5))
            .opacity(mainTabbarVM.isSideMenuOpen ? 1 : 0)
            .onTapGesture {
                withAnimation {
                    mainTabbarVM.isSideMenuOpen = false
                }
                
            }
            
            
            // menu item
            if mainTabbarVM.isSideMenuOpen{
                HStack(alignment: .top, spacing: 0){
                    
                    MenuContent(sideviewViewModel: sideViewModel)
                        .frame(width: width)
                        .shadow(radius: 10)
                    
                    Spacer()
                    
                }
                .transition(.move(edge: .leading))
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .environment(sideViewModel)
        .onAppear(perform: {
            sideViewModel.navigate = navigate
            sideViewModel.homeVM = homeVM
            sideViewModel.mainTabbarVM = mainTabbarVM
            sideViewModel.fetchAllAppointments()
        })
    }
}

struct MenuContent: View{
    @Bindable var sideviewViewModel: SideviewViewModel
    
    var body: some View{
        ZStack(alignment: .bottom){
            Color("Primary")
                .ignoresSafeArea(edges: .all)
            
            VStack(alignment: .leading, spacing: 0){
                
                HStack(alignment:.center){
                    Text("Menu")
                        .font(.largeTitle.bold())
                        .foregroundStyle(Color.white)
                    
                    Spacer()
                }
                .padding()
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.white.opacity(0.5))
                
                ScrollView(.vertical){
                    ForEach(MenuItems.allCases, id:\.self) { item in
                        
                        VStack(alignment: .leading,spacing: 0){
                            Button(action: {
                                sideviewViewModel.showMenuDetails(for: item)
                            }, label: {
                                Label {
                                    Text(item.title)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                } icon: {
                                    Image(systemName: item.systemImage)
                                        .padding(.trailing, 10)
                                }
                                .foregroundStyle(Color.white)
                                
                                .padding()
                            })
                            
                            
                            
                            Divider()
                                .background(Color.white)
                        }
                    }
                }
                .padding()
                Spacer()
                
                VStack(alignment: .leading, spacing: 0){
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white.opacity(0.5))
                    
                    Button(action: {
                        sideviewViewModel.logOutUser()
                    }, label: {
                        Label {
                            Text("Logout")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } icon: {
                            Image(systemName: "power")
                                .padding(.trailing, 10)
                        }
                        .foregroundStyle(Color.white)
                        .padding()
                        .padding(.horizontal)
                    })
                    

                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.white.opacity(0.5))
                }
                
                .padding(.bottom,50)
                
            }
            
        }
    }
}

#Preview {
    SideView(width: 300)
        .environment(MainTabbarViewModel())
        .environment(SideviewViewModel())
}
