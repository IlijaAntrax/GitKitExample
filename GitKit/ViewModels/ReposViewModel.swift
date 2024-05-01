//
//  ReposViewModel.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

final class ReposViewModel: ObservableObject {
    
    // MARK: - Private Properties
    // Use Cases
    private let getReposUseCase: GetRepositoriesUseCase
    private let getUsernameUseCase: GetUsernameUseCase
    
    // MARK: - Public Properties
    // Repos
    
    // MARK: - Init methods
    
    init(getReposUseCase: GetRepositoriesUseCase,
         getUsernameUseCase: GetUsernameUseCase) {
        self.getReposUseCase = getReposUseCase
        self.getUsernameUseCase = getUsernameUseCase
    }
    
    // MARK: - Public Methods
    
    func getRepositories(handler: @escaping (Bool) -> Void) { // TODO: Add pagination
        guard let username = getUsernameUseCase.invoke() else { return }
        getReposUseCase.invoke(username: username) { result in
            switch result {
            case .success(let model):
                handler(true)
            case .failure(let err):
                handler(false)
            }
        }
    }
}
