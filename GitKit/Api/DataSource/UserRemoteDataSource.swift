//
//  UserRemoteDataSource.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation
import Alamofire

final class UserRemoteDataSource {
    
    // MARK: - Typealias
    typealias GetUserCompletionHandler = (Result<UserResponse, NetworkError>) -> Void
    
    // MARK: - Private Properties
    private let service: AlamofireService
    
    // MARK: - Init
    init(service: AlamofireService) {
        self.service = service
    }
    
    /// - Parameter username: The `String` value of github username.
    /// - Returns:         Result of response `UserResponse` or error.
    func getUser(username: String, completion: @escaping GetUserCompletionHandler) {
        let endPoint = Endpoint<UserResponse>(path: "users/\(username)", method: .get)
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
