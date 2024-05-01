//
//  NetworkConfig.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation
import Alamofire

public protocol NetworkConfigurable {
    var baseURL: String { get }
    var baseApiURL : String { get }
    var headers: HTTPHeaders { get }
    var mediaURL: String { get }
}

public struct ApiDataNetworkConfig: NetworkConfigurable {
    public let baseURL: String
    public let baseApiURL : String
    public var headers: HTTPHeaders
    public var mediaURL: String
    
    public init(baseURL: String, baseApiURL: String, headers: HTTPHeaders, mediaURL: String) {
        self.baseURL = baseURL
        self.baseApiURL = baseApiURL
        self.headers = headers
        self.mediaURL = mediaURL
    }
}
