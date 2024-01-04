//
//  MainTabbarViewModel.swift
//  DoctorX
//
//  Created by Nayan Khadase on 10/12/23.
//

import Foundation
import Observation

@Observable
class MainTabbarViewModel{
    
    var alertmanager: AlertManager?
    var navigate: navigateType?
//    var progressBar: ProgressbarViewModel?
//    var sideviewVM: SideviewViewModel?
    
    var selectedTab: Int = 1
    
    var showHamburger: Bool {
        return selectedTab == 1
    }
    
    var isSideMenuOpen = false
    

//    func logOutUser(){
//        User.shared.deleteUser()
//        navigate?(.unWind(.loginIn))
//    }
    
//    func showMenuDetails(for menu: MenuItems){
//        switch menu {
//        case .profile:
//            break
//        case .history:
//            break
//        case .appointments:
//            if sideviewVM != nil{
//                navigate?(.push(.appointments(sideviewVM!)))
//            }
//        case .orders:
//            break
//        }
//    }
    
    
    
}

enum MenuItems: CaseIterable{
    case profile
    case address
    case appointments
    case orders
    
    var systemImage: String{
        switch self {
        case .profile:
            "person"
        case .address:
            "house"
        case .appointments:
            "list.bullet.rectangle.portrait"
        case .orders:
            "cart"
        }
    }
    
    var title: String{
        switch self {
        case .profile:
            "Profile"
        case .address:
            "Address"
        case .appointments:
            "Appointments"
        case .orders:
            "Orders"
        }
    }
}
