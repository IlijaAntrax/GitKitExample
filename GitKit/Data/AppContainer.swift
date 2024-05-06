//
//  AppContainer.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

/// Class that provide view models for views.
final class AppContainer {
    
    // MARK: Provide setup
    
    private static let baseUrl = "https://api.github.com/"
    
    // MARK: - Provide service with config
    
    private static func provideNetworkService() -> AlamofireService {
        let config = ApiDataNetworkConfig(baseURL: baseUrl, baseApiURL: baseUrl, headers: .default, mediaURL: baseUrl)
        return AlamofireService(networkConfig: config)
    }
    
    // MARK: - Provide data sources
    
    private static func provideUserRemoteDataSource() -> UserRemoteDataSource {
        return UserRemoteDataSource(service: provideNetworkService())
    }
    
    private static func provideUserLocalDataSource() -> UserLocalDataSource {
        return UserLocalDataSource()
    }
    
    private static func provideReposRemoteDataSource() -> ReposRemoteDataSource {
        return ReposRemoteDataSource(service: provideNetworkService())
    }
    
    // MARK: - Provide repositories
    
    private static func provideUserRepository() -> UserRepository {
        return UserRepository(userRemoteDataSource: provideUserRemoteDataSource(), userLocalDataSource: provideUserLocalDataSource())
    }
    
    private static func provideReposRepository() -> ReposRepository {
        return ReposRepository(reposRemoteDataSource: provideReposRemoteDataSource())
    }
    
    // MARK: - Provide use cases
    
    private static func provideGetUsernameUseCase() -> GetUsernameUseCase {
        return GetUsernameUseCaseImplementation(userRepository: provideUserRepository())
    }
    
    private static func provideSaveUsernameUseCase() -> SaveUsernameUseCase {
        return SaveAppTokenUseCaseImplementation(userRepository: provideUserRepository())
    }
    
    private static func provideGetUserDataUseCase() -> GetUserDataUseCase {
        return GetUserDataUseCaseImplementation(userRepository: provideUserRepository())
    }
    
    private static func provideGetReposUseCase() -> GetRepositoriesUseCase {
        return GetRepositoriesUseCaseImplementation(reposRepository: provideReposRepository())
    }
    
    private static func provideGetCommitsUseCase() -> GetCommitsUseCase {
        return GetCommitsUseCaseImplementation(reposRepository: provideReposRepository())
    }
    
    // MARK: - Provide view models
    
    static func provideAuthViewModel() -> AuthViewModel {
        return AuthViewModel(getUsernameUseCase: provideGetUsernameUseCase(),
                             saveUsernameUseCase: provideSaveUsernameUseCase(),
                             getUserDataUseCase: provideGetUserDataUseCase())
    }
    
    static func provideUserViewModel() -> UserViewModel {
        return UserViewModel(getUsernameUseCase: provideGetUsernameUseCase(),
                             saveUsernameUseCase: provideSaveUsernameUseCase(),
                             getUserDataUseCase: provideGetUserDataUseCase())
    }
    
    static func provideReposViewModel() -> ReposViewModel {
        return ReposViewModel(getReposUseCase: provideGetReposUseCase(),
                              getUsernameUseCase: provideGetUsernameUseCase())
    }
    
    static func provideCommitsViewModel() -> CommitsViewModel {
        return CommitsViewModel(getCommitsUseCase: provideGetCommitsUseCase(),
                                getUsernameUseCase: provideGetUsernameUseCase())
    }
}
