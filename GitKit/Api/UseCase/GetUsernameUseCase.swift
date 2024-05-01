//
//  GetUsernameUseCase.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

public protocol GetUsernameUseCase {
    /// Returns username stored localy in user defaults.
    ///
    /// - Returns:         Username `String` from local data source saved in login process or nil.
    func invoke() -> String?
}

final class GetUsernameUseCaseImplementation {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
}

extension GetUsernameUseCaseImplementation: GetUsernameUseCase {
    public func invoke() -> String? {
        return self.userRepository.getUsername()
    }
}
