//
//  MedicineViewViewModel.swift
//  DoctorX
//
//  Created by Nayan Khadase on 03/01/24.
//

import Foundation
import Observation

@Observable
class MedicineViewViewModel{
    var productIncart: [MedicineModel] = []
    var medicines: [MedicineModel] = [] //DummyData.dummyMedicines
    
    
    let networking = Networking.shared
    
    var alertManager: AlertManager?
    var progressBar: ProgressbarViewModel?
    
    
    func fetchAllMedicines(){
        Task{
            await self.get_AllMedicines()
        }
    }
    
    private func get_AllMedicines() async{
        defer{
            progressBar?.hideProgressBar()
        }
        
        do {
            
            progressBar?.showProgressBar()
            
            let medicines = try await networking.getAllMedicine()
            self.medicines = medicines
            
        } catch NetworkError.otherError(let msg) {
            print(msg)
            self.alertManager?.presentAlert(with: "Error", message: msg)
            
        } catch let error{
            print(error.localizedDescription)
            self.alertManager?.presentAlert(with: "Error", message: error.localizedDescription)
        }
    }
   
}
