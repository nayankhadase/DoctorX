//
//  Networking.swift
//  DoctorX
//
//  Created by Nayan Khadase on 10/12/23.
//

import Foundation




class Networking: NSObject {
    //    let urlString = "http://192.168.223.248:3000/" // Office network IP: 192.168.223.248
//    let urlString = "http://127.0.0.1:3000/" //Localhost:  127.0.0.1
//        let urlString = "http://192.168.1.4:3000/" // Room network IP: 192.168.1.11
    //192.168.1.11
    static let shared = Networking()
    private override init(){}

    //
    func getAllDrCategory() async throws -> [DrCategory]{
        guard let url = URL.drCategories else{
            throw NetworkError.invalidUrl
        }
        let resources = Resource<[DrCategory]>(url: url)
        do{
            let drCategories = try await HttpUtility.load(resources)
            return drCategories
        }catch let err{
            throw err
        }
    }
    
    func getAllDoctors() async throws -> [Doctor]{
        guard let url = URL.allDoctors else{
            throw NetworkError.invalidUrl
        }
        let resources = Resource<[Doctor]>(url: url)
        do{
            let doctors = try await HttpUtility.load(resources)
            return doctors
        }catch let err{
            throw err
        }
    }
    
    func getAllMedicine() async throws -> [MedicineModel]{
        guard let url = URL.allMedicines else{
            throw NetworkError.invalidUrl
        }
        let resources = Resource<[MedicineModel]>(url: url)
        do {
            let medicines = try await HttpUtility.load(resources)
            return medicines
        } catch let err {
            throw err
        }
    }
    
    
    //MARK: - Login / registration
    
    func loginUser(email: String, password: String) async throws -> UserModel{
        guard let url = URL.loginUser else{
            throw NetworkError.invalidUrl
        }
        let param = [
            "email": email,
            "password": password
        ]
        
        let data = try JSONSerialization.data(withJSONObject: param)
        
        let resource = Resource<UserModel>(url: url, method: .post(data))
        
        do {
            let user = try await HttpUtility.load(resource)
            return user
        } catch let err {
            throw err
        }
    }
    
    func registerUser(email: String, password: String) async throws -> UserModel{
        guard let url = URL.registration else{
            throw NetworkError.invalidUrl
        }
        let param = [
            "email": email,
            "password": password
        ]
        
        let data = try JSONSerialization.data(withJSONObject: param)
        
        let resource = Resource<UserModel>(url: url, method: .post(data))
        
        do {
            let user = try await HttpUtility.load(resource)
            return user
        } catch let err {
            throw err
        }
    }
    
    func updateUserDetails(params: [String:Any]) async throws -> UserModel{
        guard let url = URL.updateUser else{
            throw NetworkError.invalidUrl
        }
        
        let data = try JSONSerialization.data(withJSONObject: params)
        
        let resource = Resource<UserModel>(url: url, method: .post(data))
        
        do {
            let user = try await HttpUtility.load(resource)
            return user
        } catch let err {
            throw err
        }
    }
    
    
    func bookAppointment(params: [String:Any]) async throws -> Bool{
        guard let url = URL.bookAppintment else{
            throw NetworkError.invalidUrl
        }
        
        let data = try JSONSerialization.data(withJSONObject: params)
        
        let resource = Resource<Bool>(url: url, method: .post(data))
        do {
            let isBooked = try await HttpUtility.load(resource)
            return isBooked
        } catch let err {
            throw err
        }
    }
    
    func fetchAllAppointments(params: [String:Any]) async throws -> [Appointment]{
        guard let url = URL.fetchAppointment else{
            throw NetworkError.invalidUrl
        }
        
        let data = try JSONSerialization.data(withJSONObject: params)
        
        let resource = Resource<[Appointment]>(url: url, method: .post(data))
        do {
            let appts = try await HttpUtility.load(resource)
            return appts
        } catch let err {
            throw err
        }
    }
    
    func uploadUserProfileImage(params: UserProfileImageModel) async throws -> UserModel{
        guard let url = URL.updateUser else{
            throw NetworkError.invalidUrl
        }
        let imageResource = FileUploadResource<UserModel>(url: url,method: .post(params.attachment), fileName: params.fileName, userId: params.userId)
        do {
            let user = try await HttpUtility.uploadImage(imageResource)
            print("image uploaded: \(user.getProfileImagePath ?? "")")
            return user
        } catch let err {
            throw err
        }
    }
    
    
}

/*
 let session = URLSession(configuration: .default)
 let task = session.dataTask(with: url) { data, response, error in
     if error != nil{
         print(error!)
     }
     
     guard let safeData = data else {return}
     let decoder = JSONDecoder()
     do {
         let decodedData = try decoder.decode(UserModel.self, from: safeData)
         print("decodedData: \(decodedData) \n\n")
         DispatchQueue.main.async {
             completion(decodedData,nil)
         }
     }catch let err{
         completion(nil,NetworkError.serverError(err))
     }
     
 }
 task.resume()
 */
