//
//  SaveUsernameUseCase.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

public protocol SaveUsernameUseCase {
    /// Save username localy in user defaults.
    ///
    /// - Parameter username: The `String` value for username returned from login process.
    func invoke(username: String?)
}

final class SaveAppTokenUseCaseImplementation {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
}

extension SaveAppTokenUseCaseImplementation: SaveUsernameUseCase {
    public func invoke(username: String?) {
        self.userRepository.saveUsername(username)
    }
}
