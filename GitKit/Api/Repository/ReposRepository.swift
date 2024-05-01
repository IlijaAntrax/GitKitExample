//
//  ReposRepository.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

final class ReposRepository {
    
    // MARK: - Typealias
    typealias GetReposCompletionHandler = (Result<[RepositoryModel], NetworkError>) -> Void
    typealias GetCommitsCompletionHandler = (Result<[CommitModel], NetworkError>) -> Void
    
    // MARK: - Private Properties
    private let reposRemoteDataSource: ReposRemoteDataSource
    
    // MARK: - Init
    init(reposRemoteDataSource: ReposRemoteDataSource) {
        self.reposRemoteDataSource = reposRemoteDataSource
    }
}
    
// MARK: - Repository Methods from remote data source
extension ReposRepository {
    /// - Parameter username: The `String` value of github username.
    /// - Returns:         Result of response `RepositoryResponse` or error.
    func getRepos(username: String, completion: @escaping GetReposCompletionHandler) {
        self.reposRemoteDataSource.getRepos(username: username) { result in
            switch result {
            case .success(let reposResponse):
                completion(.success(reposResponse.map({ $0.mapTo()! })))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    /// - Parameter username: The `String` value of github username.
    /// - Parameter repo: The `String` value of github repository name.
    /// - Returns:         Result of response `RepositoryResponse` or error.
    func getCommits(username: String, repo: String, completion: @escaping GetCommitsCompletionHandler) {
        self.reposRemoteDataSource.getCommits(username: username, repo: repo) { result in
            switch result {
            case .success(let commitsResponse):
                completion(.success(commitsResponse.map({ $0.mapTo()! })))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
