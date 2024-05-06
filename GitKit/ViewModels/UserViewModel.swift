//
//  UserViewModel.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 6.5.24..
//

import Foundation

final class UserViewModel: ObservableObject {
    
    // MARK: - Private Properties
    // Use Cases
    private let getUsernameUseCase: GetUsernameUseCase
    private let saveUsernameUseCase: SaveUsernameUseCase
    private let getUserDataUseCase: GetUserDataUseCase
    
    // MARK: - Public Properties
    // User
    @Published var username: String = ""
    @Published var avatarUrl: String = ""
    @Published var fullName: String = ""
    @Published var company: String = ""
    @Published var email: String = ""
    
    @Published var isLoggedIn = true
    
    // MARK: - Init methods

    init(getUsernameUseCase: GetUsernameUseCase,
         saveUsernameUseCase: SaveUsernameUseCase,
         getUserDataUseCase: GetUserDataUseCase) {
        self.getUsernameUseCase = getUsernameUseCase
        self.saveUsernameUseCase = saveUsernameUseCase
        self.getUserDataUseCase = getUserDataUseCase
        
        getUserDetails()
    }
    
    // MARK: - Public Properties
    
    func getUserDetails() {
        if let username = getUsernameUseCase.invoke() {
            guard !username.isEmpty else { return }
            getUserDataUseCase.invoke(username: username) { result in
                switch result {
                case .success(let model):
                    self.username = model.username ?? ""
                    self.avatarUrl = model.avatarUrl ?? ""
                    self.fullName = model.fullName ?? ""
                    self.company = model.company ?? ""
                    self.email = model.email ?? ""
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func logout() {
        saveUsernameUseCase.invoke(username: nil)
        isLoggedIn = false
    }
}
