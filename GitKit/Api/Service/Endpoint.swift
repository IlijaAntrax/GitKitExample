//
//  Endpoint.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation
import Alamofire

public enum BodyEncoding {
    case jsonSerializationData
    case stringEncodingAscii
}

public class Endpoint<R>: ResponseRequestable {
   
    public typealias Response = R
    
    public let path: String
    public let isIncludeApiPath: Bool
    public let method: HTTPMethod
    public let headerParamaters: HTTPHeaders
    public let queryParametersEncodable: Encodable?
    public let queryParameters: [String: Any]
    public let bodyParamatersEncodable: Encodable?
    public let bodyParamaters: [String: Any]?
    public let bodyEncoding: ParameterEncoding
    public let responseDecoder: ResponseDecoder
    public var interceptor: RequestInterceptor?
    
    public init(path: String, includeApiExtension: Bool = true, method: HTTPMethod, headerParamaters: HTTPHeaders = HTTPHeaders(), queryParametersEncodable: Encodable? = nil, queryParameters: [String: Any] = [:], bodyParamatersEncodable: Encodable? = nil, bodyParamaters: [String: Any]? = nil, bodyEncoding: ParameterEncoding = JSONEncoding.default, responseDecoder: ResponseDecoder = CLJSONResponseDecoder(), interceptor: RequestInterceptor? = nil) {
        self.path = path
        self.isIncludeApiPath = includeApiExtension
        self.method = method
        self.headerParamaters = headerParamaters
        self.queryParametersEncodable = queryParametersEncodable
        self.queryParameters = queryParameters
        self.bodyParamatersEncodable = bodyParamatersEncodable
        self.bodyParamaters = bodyParamaters
        self.bodyEncoding = bodyEncoding
        self.responseDecoder = responseDecoder
        self.interceptor = interceptor
    }
    
    public init(endpoint: Endpoint, interceptor: RequestInterceptor? = nil) {
        self.path = endpoint.path
        self.isIncludeApiPath = endpoint.isIncludeApiPath
        self.method = endpoint.method
        self.headerParamaters = endpoint.headerParamaters
        self.queryParametersEncodable = endpoint.queryParametersEncodable
        self.queryParameters = endpoint.queryParameters
        self.bodyParamatersEncodable = endpoint.bodyParamatersEncodable
        self.bodyParamaters = endpoint.bodyParamaters
        self.bodyEncoding = endpoint.bodyEncoding
        self.responseDecoder = endpoint.responseDecoder
        self.interceptor = interceptor
    }
}

public protocol Requestable {
    var path: String { get }
    var isIncludeApiPath: Bool { get }
    var method: HTTPMethod { get }
    var headerParamaters: HTTPHeaders { get }
    var queryParametersEncodable: Encodable? { get }
    var queryParameters: [String: Any] { get }
    var bodyParamatersEncodable: Encodable? { get }
    var bodyParamaters: [String: Any]? { get }
    var bodyEncoding: ParameterEncoding { get }
    var interceptor: RequestInterceptor? { get }
}

public protocol ResponseRequestable: Requestable {
    associatedtype Response
    
    var responseDecoder: ResponseDecoder { get }
}

extension Requestable {
    
    private func url(with config: NetworkConfigurable) -> String {
        let baseURL = isIncludeApiPath ? config.baseApiURL : config.baseURL
        let url = baseURL + self.path
        return url
    }
    
    func provideRequest(with config: NetworkConfigurable) throws -> DataRequest {
        var allHeaders = config.headers
        headerParamaters.forEach { allHeaders.update($0) }
        let bodyParamaters = try bodyParamatersEncodable?.toDictionary() ?? self.bodyParamaters
        return AF.request(self.url(with: config),
                          method: self.method,
                          parameters: bodyParamaters,
                          encoding: self.bodyEncoding,
                          headers: allHeaders,
                          interceptor: interceptor)
    }
    
    private func encodeBody(bodyParamaters: [String: Any], bodyEncoding: BodyEncoding) -> Data? {
        switch bodyEncoding {
        case .jsonSerializationData:
            return try? JSONSerialization.data(withJSONObject: bodyParamaters)
        case .stringEncodingAscii:
            return bodyParamaters.queryString.data(using: String.Encoding.ascii, allowLossyConversion: true)
        }
    }
}

public protocol EndpointProvidable {
    static func provideEndpoint<T>(_ endpoint: Endpoint<T>) -> Endpoint<T>
}
