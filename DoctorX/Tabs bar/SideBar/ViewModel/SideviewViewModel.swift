//
//  SideviewViewModel.swift
//  DoctorX
//
//  Created by Nayan Khadase on 25/12/23.
//

import Foundation
import SwiftUI
import Observation

@Observable
class SideviewViewModel{
    private var networking = Networking.shared
    
    var navigate: navigateType?
    var homeVM: HomeViewModel?
    var mainTabbarVM: MainTabbarViewModel?
    
    var upcommingAppt: [Appointment] = []
    
    var historyAppt: [Appointment] = []
    
    var showAlert = false
    
    func logOutUser(){
        User.shared.deleteUser()
        navigate?(.unWind(.loginIn))
    }
    
    func showMenuDetails(for menu: MenuItems){
        mainTabbarVM?.isSideMenuOpen.toggle()
        switch menu {
        case .profile:
            navigate?(.push(.profile(self)))
        case .address:
            navigate?(.push(.address))
        case .appointments:
            navigate?(.push(.appointments(self, homeVM!)))
        case .orders:
            break
        }
    }
    
    func fetchAllAppointments(){
        Task{
            await fetch_allAppointment()
        }
    }
    
    private func fetch_allAppointment() async{
        let params: [String:Any] = [
            "userId": User.shared.userId ?? ""
        ]
        
        do {
            let allApts = try await networking.fetchAllAppointments(params: params)
            print(allApts)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd h:mm a"
            
            
            var upcomming: [Appointment] = []
            var history: [Appointment] = []
            for appointment in allApts {
                if appointment.isUpcomming{
                    upcomming.append(appointment)
                }else{
                    history.append(appointment)
                }
            }
            upcommingAppt = upcomming
            historyAppt = history
            
        }  catch let err as NetworkError{
            print(err.localizedDescription)
        } catch let err{
            print("error: \(err.localizedDescription)")
        }
    }
    func handleProfilePhotoChange(image: UIImage){
        Task{
            await handle_ProfilePhotoChange(image:image)
        }
    }
    
    private func handle_ProfilePhotoChange(image: UIImage) async{
        
        guard let imgData = image.jpegData(compressionQuality: 0.4) else {
            print("image data not found")
            return
        }
        let params = UserProfileImageModel(attachment: imgData, fileName: UUID().uuidString, userId: User.shared.userId ?? "")
        
        do {
            let user = try await networking.uploadUserProfileImage(params: params)
            User.shared.profileImagePath = user.getProfileImagePath
            
            
            print("Image updated secessfully")
        }  catch let err as NetworkError{
            print(err.localizedDescription)
        } catch let err{
            print("error: \(err.localizedDescription)")
        }
    }
    
    
}

struct UserProfileImageModel: Codable{
    let attachment: Data
    let fileName: String
    let userId: String
}
