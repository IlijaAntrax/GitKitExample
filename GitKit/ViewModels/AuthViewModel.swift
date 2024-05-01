//
//  AuthViewModel.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

final class AuthViewModel: ObservableObject {
    // MARK: - Public Properties
    // Auth
    @Published var username: String = ""
    
    // MARK: - Public methods
    func login() {
        guard !username.isEmpty else { return }
        
    }
}
