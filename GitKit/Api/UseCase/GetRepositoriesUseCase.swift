//
//  GetRepositoriesUseCase.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

protocol GetRepositoriesUseCase {
    typealias GetRepositoriesCompletion = (Result<[RepositoryModel], NetworkError>) -> Void
    /// Returns in completion handler a `RepositoryModel` struct that contains repository details returned from github server.
    ///
    /// User should exist on github server. This use case may retrun 404 error if user not exists.
    ///
    /// - Returns:         In completion result of model `RepositoryModel` or error.
    func invoke(username: String, completion: @escaping GetRepositoriesCompletion)
}

final class GetRepositoriesUseCaseImplementation {
    private let reposRepository: ReposRepository
    
    init(reposRepository: ReposRepository) {
        self.reposRepository = reposRepository
    }
}

extension GetRepositoriesUseCaseImplementation: GetRepositoriesUseCase {
    func invoke(username: String, completion: @escaping GetRepositoriesCompletion) {
        self.reposRepository.getRepos(username: username) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
