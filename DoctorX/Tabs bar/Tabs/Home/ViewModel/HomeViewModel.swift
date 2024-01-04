//
//  HomeViewModel.swift
//  DoctorX
//
//  Created by Nayan Khadase on 10/12/23.
//

import Foundation
import SwiftUI
import Observation

@Observable
class HomeViewModel{
    private var networking = Networking.shared
    
    var doctorCategory: [DrCategory] = []
    private var allDoctors: [Doctor] = []
    var doctors: [Doctor] = []
    var isLoading: Bool = true
    
    var showErrorAlert = false
    
    var upcommingAppointments: [Appointment] = []
    var historyAppointments: [Appointment] = []
    //
    var drCategoryFileCache: CacheFile?
    
    // 
    
    init(){
        // create cache directory
        drCategoryFileCache = CacheFile(key: "DoctorCategory", cacheDirName: "doctorCategoryCache")
        getDrCat()
        getAllDoctors()
    }
    func getDrCat(){
        Task{
            await getDoctorCategory()
            isLoading = false
        }
    }
    
    func getAllDoctors(){
        Task{
            await getAllDrs()
            await fetch_allAppointment()
            isLoading = false
        }
    }
    
    func getDoctorCategory() async{
        
        // check in cache
//        if let drArray = StoreData.loadArrayFromStore(for: UDKey.doctorCategory) as? [DrCategory]{
//            doctorCategory = drArray
//            print("Used from store data")
//            return
//        }
    
        // get from net
//        
        do{
            let drArr = try await networking.getAllDrCategory()
            DispatchQueue.main.async {
                self.doctorCategory = drArr
            }
        }catch let err as NetworkError{
            print(err.localizedDescription)
            self.showErrorAlert = true
        } catch let err{
            print("error: \(err.localizedDescription)")
            self.showErrorAlert = true
        }
    }
    
    func getAllDrs() async{
        do {
            let doctors = try await networking.getAllDoctors()
        
            DispatchQueue.main.async {
                self.allDoctors = doctors
                self.getFilterDoctors(type: "general")
            }
        } catch let err as NetworkError{
            print(err.localizedDescription)
            self.showErrorAlert = true
        } catch let err{
            print("error: \(err.localizedDescription)")
            self.showErrorAlert = true
        }
    }
    
    func getFilterDoctors(type: String){
        let filteredDr = allDoctors.filter { doctor in
            doctor.type == type
        }
        DispatchQueue.main.async {
            withAnimation {
                self.doctors = filteredDr
            }
        }
    }
    
    func bookAppointment(drId: String, date: Date, type: String){
        Task{
            await self.book_appointment(drId: drId, date: date, type: type)
            await fetch_allAppointment()
        }
    }
    
    private func book_appointment(drId: String, date: Date, type: String) async{
        
        let params: [String: Any] = [
            "userId" : User.shared.userId ?? "",
            "doctorId": drId,
            "date" : Double(date.timeIntervalSince1970),
            "consultationType" : type
        ]
        
        do {
            let isBooked = try await networking.bookAppointment(params: params)
            print("appointment \(isBooked)")
        } catch let err as NetworkError{
            print(err.localizedDescription)
        } catch let err{
            print("error: \(err.localizedDescription)")
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
            
            for appointment in allApts {
                if appointment.isUpcomming{
                    upcomming.append(appointment)
                }
            }
            
//            DispatchQueue.main.async {
                self.upcommingAppointments = upcomming
//            }
        }  catch let err as NetworkError{
            print(err.localizedDescription)
        } catch let err{
            print("error: \(err.localizedDescription)")
        }
    }
    
    
    
    
}
