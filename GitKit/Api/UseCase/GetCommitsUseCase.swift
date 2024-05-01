//
//  GetCommitsUseCase.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

protocol GetCommitsUseCase {
    typealias GetCommitsCompletion = (Result<[CommitModel], NetworkError>) -> Void
    /// Returns in completion handler a `CommitModel` struct that contains commitr data returned from github server.
    ///
    /// User should exist on github server. This use case may retrun 404 error if user not exists.
    ///
    /// - Returns:         In completion result of model `CommitModel` or error.
    func invoke(username: String, repo: String, completion: @escaping GetCommitsCompletion)
}

final class GetCommitsUseCaseImplementation {
    private let reposRepository: ReposRepository
    
    init(reposRepository: ReposRepository) {
        self.reposRepository = reposRepository
    }
}

extension GetCommitsUseCaseImplementation: GetCommitsUseCase {
    func invoke(username: String, repo: String, completion: @escaping GetCommitsCompletion) {
        self.reposRepository.getCommits(username: username, repo: repo) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
