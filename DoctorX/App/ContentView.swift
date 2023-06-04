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
                    MainTabBarView()
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
