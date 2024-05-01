//
//  AlamofireService.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation
import Alamofire

public class AlamofireService {
    
    private let logger: NetworkLogger
    private let config: NetworkConfigurable
    
    public typealias CompletionHandler<T> = (Result<T?, NetworkError>) -> Void
    
    public init(networkConfig: NetworkConfigurable) {
        logger = NetworkLogger()
        config = networkConfig
    }
    
    public func executeRequest<T>(endpoint: Endpoint<T>, completion: @escaping CompletionHandler<T>) where T : Decodable {
        if let request = try? endpoint.provideRequest(with: config) {
            request.response { (response) in
                self.logger.log(response: response)
                switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let responseData: T = try endpoint.responseDecoder.decode(data)
                            completion(.success(responseData))
                        } catch {
                            completion(.failure(.parsing(error)))
                        }
                    } else {
                        if response.hasSuccessStatusCode {
                            completion(.success(nil))
                        } else {
                            completion(.failure(.error(statusCode: response.response?.statusCode ?? 400, data: nil)))
                        }
                    }
                case .failure(let error):
                    completion(.failure(self.resolve(error: error)))
                }
            }
        } else {
            completion(.failure(.urlGeneration))
        }
    }
    
    
    
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
            case .notConnectedToInternet: return .notConnected
            case .cancelled: return .cancelled
            default: return .generic(error)
        }
    }
}
