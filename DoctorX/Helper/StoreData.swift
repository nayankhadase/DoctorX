//
//  StoreData.swift
//  DoctorX
//
//  Created by Nayan Khadase on 10/12/23.
//

import Foundation


class StoreData{
    private static let userDefault = UserDefaults.standard
    
    // Any data
    class func saveToStore(data: Any, for key: String){
        StoreData.userDefault.set(data, forKey: key)
    }
    
    class func loadFromStore(for key: String) -> Any?{
        StoreData.userDefault.object(forKey: key)
    }
    
    // delete
    class func deleteFromStore(for key: String){
        StoreData.userDefault.removeObject(forKey: key)
    }
    
    // Dictionary
    class func saveDictToStore(_ dict: [String: Any], for key: String){
        StoreData.saveToStore(data: dict, for: key)
    }
    
    class func loadDictFromStore(for key: String) -> [String:Any]?{
        StoreData.loadFromStore(for: key) as? [String:Any]
    }
    
    // Array
    class func saveArrayToStore(_ array: [Any], for key: String){
        StoreData.saveToStore(data: array, for: key)
    }
    
    class func loadArrayFromStore(for key: String) -> [Any]?{
        StoreData.loadFromStore(for: key) as? [Any]
    }
    
}
