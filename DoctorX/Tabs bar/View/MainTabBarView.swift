//
//  MainTabBarView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 03/06/23.
//

import SwiftUI

struct MainTabBarView: View {
    @State private var mainTabbarVM = MainTabbarViewModel()
    @State private var homeVM = HomeViewModel()

    @Environment(\.navigate) var navigate
    @Environment(AlertManager.self) var alertManager
    
    var body: some View {
        ZStack{
            GeometryReader{ geo in
                TabView(selection: $mainTabbarVM.selectedTab) {
                    HomeView()
                        .tabItem {
                            Label {
                                Text("Home")
                            } icon: {
                                Image(systemName: "house")
                            }
                        }
                        .tag(1)
                        
                    
                    MedicineView()
                        .tabItem {
                            Label {
                                Text("Medicine")
                            } icon: {
                                Image(systemName: "pills")
                            }

                        }
                        .tag(2)
                    
                    ChatWithDrTabView()
                        .tabItem {
                            Label {
                                Text("Message")
                            } icon: {
                                Image(systemName: "message")
                            }

                        }
                        .tag(3)
                    
                    HistoryTabView()
                        .tabItem {
                            Label {
                                Text("History")
                            } icon: {
                                Image(systemName: "clock.arrow.circlepath")
                            }

                        }
                        .tag(4)
                }
                
                SideView(width: geo.size.width * 0.75)
            }
        }
        .navigationBarBackButtonHidden()
        .environment(mainTabbarVM)
        .environment(homeVM)
        .onAppear(perform: {
            mainTabbarVM.alertmanager = alertManager
            mainTabbarVM.navigate = navigate
//            mainTabbarVM.progressBar = progressbarViewModel
        })
    }
}

struct MainTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView()
            .environment(MainTabbarViewModel())
            .environment(HomeViewModel())
            .environment(AlertManager())
            .environment(SideviewViewModel())
            .environment(ProgressbarViewModel())
    }
}
