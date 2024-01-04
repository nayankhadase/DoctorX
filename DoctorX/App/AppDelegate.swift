//
//  AppDelegate.swift
//  DoctorX
//
//  Created by Nayan Khadase on 24/12/23.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        NetworkMonitor.shared.startMonitoring()
        return true
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        NetworkMonitor.shared.stopMonitoring()
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        NetworkMonitor.shared.startMonitoring()
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        NetworkMonitor.shared.startMonitoring()
    }
}
