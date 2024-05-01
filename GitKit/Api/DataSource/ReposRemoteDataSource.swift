//
//  ReposRemoteDataSource.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation
import Alamofire

final class ReposRemoteDataSource {
    
    // MARK: - Typealias
    typealias GetReposCompletionHandler = (Result<[RepositoryResponse], NetworkError>) -> Void
    typealias GetCommitsCompletionHandler = (Result<[CommitResponse], NetworkError>) -> Void
    
    // MARK: - Private Properties
    private let service: AlamofireService
    
    // MARK: - Init
    init(service: AlamofireService) {
        self.service = service
    }
    
    /// - Parameter username: The `String` value of github username.
    /// - Returns:         Result of response `RepositoryResponse` or error.
    func getRepos(username: String, completion: @escaping GetReposCompletionHandler) {
        let endPoint = Endpoint<[RepositoryResponse]>(path: "users/\(username)/repos", method: .get)
        self.service.executeRequest(endpoint: endPoint) { result in
            switch result {
            case .success(let response):
                if let response = response {
                    completion(.success(response))
                } else {
                    completion(.failure(.nullResponse))
                }
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    /// - Parameter username: The `String` value of github username.
    /// - Parameter repo: The `String` value of github repository name.
    /// - Returns:         Result of response `RepositoryResponse` or error.
    func getCommits(username: String, repo: String, completion: @escaping GetCommitsCompletionHandler) {
        let endPoint = Endpoint<[CommitResponse]>(path: "repos/\(username)/\(repo)/commits", method: .get)
        self.service.executeRequest(endpoint: endPoint) { result in
            switch result {
            case .success(let response):
                if let response = response {
                    completion(.success(response))
                } else {
                    completion(.failure(.nullResponse))
                }
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
