//
//  DtoMapper.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

public protocol DtoMappable {
    associatedtype Model where Model: Decodable
    /// - Mapper method that should map codable struct or class to decodable object of type `Model`
    func mapTo() -> Model?
}

extension DtoMappable {
    /// `R` - Response class that should confirm protocol `Codable`
    /// `M` - Model class that should confirm protocol `Decodable`
    /// - Parameter response: The `R` class or struct.
    /// - Returns:         The `M` class or struct mapped value from response `R`.
    public static func mapToDefaultModel<R: Codable, M: Decodable>(response: R) -> M? {
        let data = try? JSONEncoder().encode(response)
        if let data = data {
            let model = try? JSONDecoder().decode(M.self, from: data)
            return model
        } else {
            return nil
        }
    }
}
