//
//  DoctorXApp.swift
//  DoctorX
//
//  Created by Nayan Khadase on 01/05/23.
//

import SwiftUI

@main
struct DoctorXApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var alertManager = AlertManager()
    @State private var progressbarVM = ProgressbarViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .alert(isPresented: $alertManager.isPresented) {
                    Alert(title: Text(alertManager.title), message: Text(alertManager.message), dismissButton: .default(Text("Ok")))
                }
                .environment(alertManager)
                .environment(progressbarVM)
            
        }
    }
}
