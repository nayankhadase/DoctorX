//
//  CacheFile.swift
//  DoctorX
//
//  Created by Nayan Khadase on 10/12/23.
//

import Foundation

class CacheFile{
    var key: String // use to encript
    var cacheDirectory: String?
    
    init(key: String, cacheDirName: String) {
        self.key = key
        
        if let cacheDirUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appending(path: cacheDirName){
            cacheDirectory = cacheDirUrl.path()
            guard let _ = cacheDirectory else{
                print("Error while creating \(cacheDirName) directory path")
                return
            }
            do{
                print(cacheDirectory!)
                try FileManager.default.createDirectory(atPath: cacheDirectory!, withIntermediateDirectories: true, attributes: nil)
                print("Directory has been created for: \(cacheDirName)")
            }catch let err{
                print("Error while creating \(cacheDirName) directory: \(err.localizedDescription)")
            }
        }
        
    }
    
    func saveToFile(file fileName: String, data: Data){
        guard let cacheDirectory = self.cacheDirectory else{
            print("No cache directory found")
            return
        }
        
        let filePath = cacheDirectory + "/" + fileName
        let fileUrl = URL(filePath: filePath)
        
        do{
            try data.write(to: fileUrl, options: .completeFileProtection)
        }catch let err{
            print("Error while writing data to file: \(fileName) \(err.localizedDescription)")
        }
        
    }
    
    func getDataFrom(file fileName: String) -> Data?{
        guard let cacheDirectory = self.cacheDirectory else{
            print("No cache directory found")
            return nil
        }
        
        let filePath = cacheDirectory + "/" + fileName
        if FileManager.default.fileExists(atPath: filePath){
            do{
                let fileData = try Data(contentsOf: URL(filePath: filePath))
                return fileData
            }catch let err{
                print("Error while retriving data from \(fileName), : \(err.localizedDescription)")
                return nil
            }
        }else{
            print("No file found for \(fileName)")
            return nil
        }
        
       
    }
}
