//
//  UserLocalDataSource.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

fileprivate let kUsername = "username_key"

final class UserLocalDataSource {
    
    func getUsername() -> String? {
        return UserDefaults.standard.string(forKey: kUsername)
    }
    
    func saveUsername(_ username: String?) {
        UserDefaults.standard.setValue(username, forKey: kUsername)
        UserDefaults.standard.synchronize()
    }
}
