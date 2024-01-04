//
//  HistoryViewModel.swift
//  DoctorX
//
//  Created by Nayan Khadase on 25/12/23.
//

import Foundation
import Observation

@Observable
class HistoryViewModel{
    private var networking = Networking.shared
    
    var progressBar: ProgressbarViewModel?
    
    var historyAppointments: [Appointment] = []
    
    func fetchAllApponitments(){
        Task{
            await fetch_allAppointment()
        }
    }
    
    private func fetch_allAppointment() async{
        defer{
            progressBar?.hideProgressBar()
        }
        let params: [String:Any] = [
            "userId": User.shared.userId ?? ""
        ]
        
        do {
            progressBar?.showProgressBar()
            let allApts = try await networking.fetchAllAppointments(params: params)
            print(allApts)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd h:mm a"
            
            
            var upcomming: [Appointment] = []
            
            for appointment in allApts {
                if !appointment.isUpcomming{
                    upcomming.append(appointment)
                }
            }
            
            self.historyAppointments = upcomming
            
        }  catch let err as NetworkError{
            print(err.localizedDescription)
        } catch let err{
            print("error: \(err.localizedDescription)")
        }
    }
    
}
