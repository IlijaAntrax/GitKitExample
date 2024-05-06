//
//  AuthViewModel.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

final class AuthViewModel: ObservableObject {
    
    // MARK: - Private Properties
    // Use Cases
    private let getUsernameUseCase: GetUsernameUseCase
    private let saveUsernameUseCase: SaveUsernameUseCase
    private let getUserDataUseCase: GetUserDataUseCase
    
    // MARK: - Public Properties
    // Auth
    @Published var username: String = ""
    @Published var loginError: String = ""
    
    // MARK: - Init methods

    init(getUsernameUseCase: GetUsernameUseCase,
         saveUsernameUseCase: SaveUsernameUseCase,
         getUserDataUseCase: GetUserDataUseCase) {
        self.getUsernameUseCase = getUsernameUseCase
        self.saveUsernameUseCase = saveUsernameUseCase
        self.getUserDataUseCase = getUserDataUseCase
    }
    
    // MARK: - Public Properties
    
    var isLoggedIn: Bool {
        let username = getUsernameUseCase.invoke()
        return username != nil && !username!.isEmpty
    }
    
    func login(handler: @escaping (Bool) -> Void) {
        guard !username.isEmpty else { return }
        getUserDataUseCase.invoke(username: username) { result in
            switch result {
            case .success(_):
                self.saveUsernameUseCase.invoke(username: self.username)
                handler(true)
            case .failure(let err):
                self.loginError = err.localizedDescription
                handler(false)
            }
        }
    }
    
    func clearError() {
        loginError = ""
    }
}
