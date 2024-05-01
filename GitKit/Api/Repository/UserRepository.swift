//
//  UserRepository.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

final class UserRepository {
    
    // MARK: - Typealias
    typealias GetUserDataCompletionHandler = (Result<UserModel, NetworkError>) -> Void
    typealias UsernameCompletionHandler = (String?) -> Void
    
    // MARK: - Private Properties
    private let userRemoteDataSource: UserRemoteDataSource
    private let userLocalDataSource: UserLocalDataSource
    
    // MARK: - Init
    init(userRemoteDataSource: UserRemoteDataSource,
         userLocalDataSource: UserLocalDataSource) {
        self.userRemoteDataSource = userRemoteDataSource
        self.userLocalDataSource = userLocalDataSource
    }
}

// MARK: - Repository Methods from local data source
extension UserRepository {
    /// - Parameter username: The `String` value for username of github account from login process.
    func saveUsername(_ username: String?) {
        return userLocalDataSource.saveUsername(username)
    }
    
    /// - Returns:         Username `String` from local data source saved in login process or nil.
    func getUsername() -> String? {
        return userLocalDataSource.getUsername()
    }
}
    
// MARK: - Repository Methods from remote data source
extension UserRepository {
    /// - Parameter username: The `String` value of github username.
    /// - Returns:         Result of model `UserModel` or error.
    func getUserData(username: String, completion: @escaping GetUserDataCompletionHandler) {
        self.userRemoteDataSource.getUser(username: username) { result in
            switch result {
            case .success(let userResponse):
                if let userDataModel = userResponse.mapTo() {
                    completion(.success(userDataModel))
                } else {
                    completion(.failure(.nullResponse))
                }
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
