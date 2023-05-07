//
//  ContentView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 01/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var path = NavigationPath()
    
    
    var body: some View {
        NavigationStack(path: $path){
            ZStack{
                VStack{
                    
                    TabView {
                        HomeView()
                            .tabItem {
                                Label {
                                    Text("Home")
                                } icon: {
                                    Image(systemName: "house")
                                }

                            }
                        
                        HomeView()
                            .tabItem {
                                Label {
                                    Text("Medicine")
                                } icon: {
                                    Image(systemName: "pills")
                                }

                            }
                        
                        HomeView()
                            .tabItem {
                                Label {
                                    Text("Message")
                                } icon: {
                                    Image(systemName: "message")
                                }

                            }
                        
                        HomeView()
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
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
