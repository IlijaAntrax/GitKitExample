//
//  CommitsViewModel.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

final class CommitsViewModel: ObservableObject {
    
    // MARK: - Private Properties
    // Use Cases
    private let getCommitsUseCase: GetCommitsUseCase
    private let getUsernameUseCase: GetUsernameUseCase
    
    // MARK: - Public Properties
    // Commits
    
    // MARK: - Init methods
    
    init(getCommitsUseCase: GetCommitsUseCase,
         getUsernameUseCase: GetUsernameUseCase) {
        self.getCommitsUseCase = getCommitsUseCase
        self.getUsernameUseCase = getUsernameUseCase
    }
    
    // MARK: - Public Methods
    
    func getCommits(repo: String, handler: @escaping (Bool) -> Void) { // TODO: Add pagination
        guard let username = getUsernameUseCase.invoke() else { return }
        getCommitsUseCase.invoke(username: username, repo: repo) { result in
            switch result {
            case .success(let model):
                handler(true)
            case .failure(let err):
                handler(false)
            }
        }
    }
}
