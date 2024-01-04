//
//  NetworkMonitor.swift
//  DoctorX
//
//  Created by Nayan Khadase on 24/12/23.
//

import Foundation
import Network
import SystemConfiguration

class NetworkMonitor{
    let monitor = NWPathMonitor()
    static let shared = NetworkMonitor()
    
    private var isMonitoring = false
    
    // use it to notified that monitoring did start.
    var didStartMonitoringHandler: (() -> Void)?
    
    // use it to notified that monitoring did stopped.
    var didStopMonitoringHandler: (() -> Void)?
    
    // use it to monitor the network status changes.
    var netStatusChangeHandler: (() -> Void)?
    
    // use it to check network is connected or not.
    var isConnected: Bool {
        return monitor.currentPath.status == .satisfied
    }
    
    // current network type like cellular, wi-fi or any other...
    var interfaceType: NWInterface.InterfaceType? {
        return self.availableInterfacesTypes?.first
    }
    
    private var availableInterfacesTypes: [NWInterface.InterfaceType]? {
        return monitor.currentPath.availableInterfaces.map { $0.type }
    }
    
    
    private init(){
        
       
    }
    
    func startMonitoring(){
        // if already monitoring, return it.
        if isMonitoring { return }
        
        // running it on background thread, because we are continually monitoring the network.
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { _ in
            self.netStatusChangeHandler?()
        }
        isMonitoring = true
        didStartMonitoringHandler?()
    }
    
    // call it to stop the monitoring.
    func stopMonitoring() {
        if isMonitoring{
            monitor.cancel()
            isMonitoring = false
            didStopMonitoringHandler?()
        }
    }
    
    deinit {
        stopMonitoring()
    }
}


