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
    
    private let repoName: String
    
    // MARK: - Public Properties
    // Commits
    @Published var commits: [CommitModel] = []
    
    // MARK: - Init methods
    
    init(repo: String,
         getCommitsUseCase: GetCommitsUseCase,
         getUsernameUseCase: GetUsernameUseCase) {
        self.repoName = repo
        self.getCommitsUseCase = getCommitsUseCase
        self.getUsernameUseCase = getUsernameUseCase
        
        getCommits()
    }
    
    // MARK: - Public Methods
    
    func getCommits() { // TODO: Add pagination
        guard let username = getUsernameUseCase.invoke() else { return }
        getCommitsUseCase.invoke(username: username, repo: repoName) { result in
            switch result {
            case .success(let model):
                self.commits = model
            case .failure(_):
                break
            }
        }
    }
}
