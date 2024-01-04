//
//  HttpUtility.swift
//  DoctorX
//
//  Created by Nayan Khadase on 10/12/23.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case serverError(Error)
    case httpError
    case invalidResponse
    case decodingError
    case unknown
    
    case otherError(String)
}


enum HttpMethod{
    case get([URLQueryItem])
    case post(Data?)
    
    var name: String{
        switch self {
        case .get(_):
            return "GET"
        case .post(_):
            return "POST"
        }
    }
}

struct Resource<T: Codable>{
    let url: URL
    var method: HttpMethod = .get([])
    var attachment: String? // use for image upload
}

struct FileUploadResource<T: Codable>{
    let url: URL
    var method: HttpMethod = .get([])
    var fileName: String
    var userId: String
}


class HttpUtility{
    
    //    static let shared = HttpUtility()
    //
    //    private init(){}
    
    class func load<T: Codable>(_ resource: Resource<T>) async throws -> T{
        
        var request = URLRequest(url: resource.url)
        
        switch resource.method {
        case .get(let queryItems): // https://someurl.com/products?sort=ase&pageSize=10
            var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems
            guard let url = components?.url else{
                throw NetworkError.invalidUrl
            }
            request = URLRequest(url: url)
            request.httpMethod = resource.method.name
            
        case .post(let data):
            request.httpMethod = resource.method.name
            request.httpBody = data
        }
        
        // create the URLSession configuration
        let configuration = URLSessionConfiguration.ephemeral
        // add default header
        configuration.httpAdditionalHeaders = ["Content-Type" : "application/json"]
        // create session from configuration
        //        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 20 //TimeInterval(10)
        let session = URLSession(configuration: configuration)
        
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode == 200 else{
                try ErrorHandler.handleError(data: data, response: response)
                print("after try")
                throw NetworkError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            
            guard let result = try? decoder.decode(T.self, from: data) else{
                throw NetworkError.decodingError
            }
            
            return result
            
            
        } catch let error {
            print("error: \(error.localizedDescription)")
            throw NetworkError.serverError(error)
        }
        
        
        
    }
    
    
    
    class func uploadImage<T: Codable>(_ resource: FileUploadResource<T>) async throws -> T {
        let boundary = generateBoundary()
        let lineBreak = "\r\n"
        
        var fileData = Data()
        
        switch resource.method {
        case .get(_):
            break
        case .post(let data):
            print(data?.isEmpty)
            fileData = data ?? fileData
        }
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.method.name
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var requestData = Data()
        
        // Append image name to the request body
        requestData.append("--\(boundary)\r\n".data(using: .utf8)!)
        requestData.append("Content-Disposition: form-data; name=\"userId\"\r\n\r\n".data(using: .utf8)!)
        requestData.append("\(resource.userId)".data(using: .utf8)!)
        requestData.append("\r\n".data(using: .utf8)!)

        // Append image data to the request body
        requestData.append("--\(boundary)\r\n".data(using: .utf8)!)
        requestData.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        requestData.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        requestData.append(fileData)
        requestData.append("\r\n".data(using: .utf8)!)

        // Add any additional form fields if needed

        requestData.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = requestData
        
        

        // Add file data
//        let boundaryInit = "--\(boundary)\(lineBreak)"
//    
//        requestData.append(boundaryInit.data(using: .utf8)!)
//        requestData.append("Content-Disposition: form-data; name=\"attachment\"\(lineBreak + lineBreak)".data(using: .utf8)!)
//        requestData.append(fileData.data(using: .utf8)!)
//        requestData.append(lineBreak.data(using: .utf8)!)
//
//        // Add filename
//        requestData.append(boundaryInit.data(using: .utf8)!)
//        requestData.append("Content-Disposition: form-data; name=\"fileName\"\(lineBreak + lineBreak)".data(using: .utf8)!)
//        requestData.append("\(resource.fileName)".data(using: .utf8)!)
//        requestData.append(lineBreak.data(using: .utf8)!)
//
//        // Add user id
//        requestData.append(boundaryInit.data(using: .utf8)!)
//        requestData.append("Content-Disposition: form-data; name=\"userId\"\(lineBreak + lineBreak)".data(using: .utf8)!)
//        requestData.append("\(resource.userId)".data(using: .utf8)!)
//        requestData.append(lineBreak.data(using: .utf8)!)
//
//        // End the main boundary
//        requestData.append("--\(boundary)--\(lineBreak)".data(using: .utf8)!)
//
//        // Add content length
//        request.addValue("\(requestData.count)", forHTTPHeaderField: "content-length")
//
//        // Set http body
//        request.httpBody = requestData
        
        
        
        /////

//        var request = URLRequest(url: resource.url)
//        request.httpMethod = resource.method.name
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        
//        var requestData = Data()
//        // add file data
//        requestData.append("--\(boundary)\(lineBreak)".data(using: .utf8)!)
//        requestData.append("content-disposition: form-data; name=\"attachment\" \(lineBreak + lineBreak)".data(using: .utf8)!)
//        requestData.append(fileData)
//        
//        // add filename
//        requestData.append("\(lineBreak)--\(boundary)\(lineBreak)".data(using: .utf8)!)
//        requestData.append("content-disposition: form-data; name=\"fileName\" \(lineBreak + lineBreak)".data(using: .utf8)!)
//        requestData.append("\(resource.fileName)".data(using: .utf8)!)
//        
//        // add user id
//        requestData.append("\(lineBreak)--\(boundary)\(lineBreak)".data(using: .utf8)!)
//        requestData.append("content-disposition: form-data; name=\"userId\" \(lineBreak + lineBreak)".data(using: .utf8)!)
//        requestData.append("\(resource.userId)".data(using: .utf8)!)
//        
//        // end the main boundry
//        requestData.append("--\(boundary)--\(lineBreak)".data(using: .utf8)!)
//       
//        
//        //add content length
//        request.addValue("\(requestData.count)", forHTTPHeaderField: "content-length")
//        
//        // set http body
//        request.httpBody = requestData
        
        print("request Body ==>>\n \(String(describing: String(data: request.httpBody!, encoding: .utf8))) \n ==>>")
        
        do {
            let session = URLSession.shared
            let (data, response) = try await session.data(for: request)
            
            guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode == 200 else{
                try ErrorHandler.handleError(data: data, response: response)
                print("after try")
                throw NetworkError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            
            guard let result = try? decoder.decode(T.self, from: data) else{
                throw NetworkError.decodingError
            }
            
            return result
            
            
        } catch let error {
            print("error: \(error.localizedDescription)")
            throw NetworkError.serverError(error)
        }
    }
    
    private class func generateBoundary() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
}

//MARK: - Server address
struct ServerDetails{
    private static let ip = "192.168.1.11"
    static let baseUrl = "http://\(ip):3000/"
    static let baseHost = "\(ip):3000"
    static let publicImage = baseUrl + "public/"
}


//MARK: - URL extension
extension URL{
    // image with public
    static let baseUrl = ServerDetails.baseUrl
    static let baseHost = ServerDetails.baseHost
    
    // Auth
    static var loginUser: URL?{
        URL(string: baseUrl + "user/login")
    }
    static var registration: URL?{
        URL(string: baseUrl + "user/adduser")
    }
    static var updateUser: URL?{
        URL(string: baseUrl + "user/updateuser")
    }
    ////
    static var bookAppintment: URL?{
        URL(string: baseUrl + "user/bookappointment")
    }
    
    static var fetchAppointment: URL?{
        URL(string: baseUrl + "user/fetchappointments")
    }
    
    static var drCategories: URL?{
        URL(string: baseUrl + "user/drcategories")
    }
    
    static var allDoctors: URL?{
        URL(string: baseUrl + "user/doctors")
    }
    
    static var allMedicines: URL?{
        URL(string: baseUrl + "user/allmedicines")
    }
    
    static func forProductId(_ id: Int) -> URL?{
        var component = URLComponents()
        component.scheme = "https"
        component.host = baseHost
        component.path = "/products/\(id)"
        return component.url
    }
}
