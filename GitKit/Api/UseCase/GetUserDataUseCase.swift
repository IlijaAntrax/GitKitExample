//
//  GetUserDataUseCase.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

protocol GetUserDataUseCase {
    typealias GetUserModelCompletion = (Result<UserModel, NetworkError>) -> Void
    /// Returns in completion handler a `UserModel` struct that contains user data returned from github server.
    ///
    /// User should exist on github server. This use case may retrun 404 error if user not exists.
    ///
    /// - Returns:         In completion result of model `UserModel` or error.
    func invoke(username: String, completion: @escaping GetUserModelCompletion)
}

final class GetUserDataUseCaseImplementation {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
}

extension GetUserDataUseCaseImplementation: GetUserDataUseCase {
    func invoke(username: String, completion: @escaping GetUserModelCompletion) {
        self.userRepository.getUserData(username: username) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
