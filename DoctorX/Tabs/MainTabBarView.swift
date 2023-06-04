//
//  MainTabBarView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 03/06/23.
//

import SwiftUI

struct MainTabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label {
                        Text("Home")
                    } icon: {
                        Image(systemName: "house")
                    }

                }
            
            MedicineView()
                .tabItem {
                    Label {
                        Text("Medicine")
                    } icon: {
                        Image(systemName: "pills")
                    }

                }
            
            ChatWithDrTabView()
                .tabItem {
                    Label {
                        Text("Message")
                    } icon: {
                        Image(systemName: "message")
                    }

                }
            
            HistoryTabView()
                .tabItem {
                    Label {
                        Text("History")
                    } icon: {
                        Image(systemName: "clock.arrow.circlepath")
                    }

                }
        }
    }
}

struct MainTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView()
    }
}
