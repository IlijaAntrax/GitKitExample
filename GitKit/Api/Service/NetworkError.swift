//
//  NetworkError.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case parsing(Error)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
    case nullResponse
}

extension NetworkError {
    public var isNotFoundError: Bool { return hasStatusCode(404) }
    
    public func hasStatusCode(_ codeError: Int) -> Bool {
        switch self {
            case let .error(code, _):
                return code == codeError
            default: return false
        }
    }
}
