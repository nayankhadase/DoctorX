//
//  KeychainStore.swift
//  DoctorX
//
//  Created by Nayan Khadase on 24/12/23.
//

import Foundation
import Security

enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}

class KeychainStore{
    
    class func saveCredentialsToKeychain(username: String, password: String) -> Bool {
        let username = username
        let passwordData = password.data(using: String.Encoding.utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecValueData as String: passwordData
        ]
        
        // check if already present
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecSuccess {
            // Update existing item
            guard var existingAttributes = item as? [String: Any] else {
                return false
            }
            existingAttributes[kSecValueData as String] = passwordData

            let updateStatus = SecItemUpdate(existingAttributes as CFDictionary, query as CFDictionary)
            guard updateStatus == errSecSuccess else {
                // Handle update error
                return false
            }
            print("Keychain item updated successfully")
            return true

        } else if status == errSecItemNotFound {
            // Add new item
            let addStatus = SecItemAdd(query as CFDictionary, nil)
            guard addStatus == errSecSuccess else {
                return false
            }
            return true

        } else {
            // Handle other errors (e.g., errSecDuplicateItem)
            print("Keychain error: \(status)")
            return false
        }
    
    }
    
    class func retrieveCredentialsFromKeychain(username: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        
        // Check if user exists in the keychain
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            // Extract result
            if let existingItem = item as? [String: Any],
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let password = String(data: passwordData, encoding: .utf8)
            {
                return password
            }
        }
        return nil
    }
    
    class func deleteUserCredential(for username: String){
        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
        ]
        // Find user and delete
        if SecItemDelete(query as CFDictionary) == noErr {
            print("User removed successfully from the keychain")
        } else {
            print("Something went wrong trying to remove the user from the keychain")
        }
    }
    
    
}
