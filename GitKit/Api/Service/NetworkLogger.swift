//
//  NetworkLogger.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation
import Alamofire

public final class NetworkLogger {
    public init() { }

    public func log(request: DataRequest) {
        print("-------------")
        print("Request: \(request.request?.url?.absoluteString ?? "")")
        print("Headers: \(request.request?.headers.dictionary ?? [String:String]())")
        print("Method: \(request.request?.method?.rawValue ?? "")")
        if let httpBody = request.request?.httpBody, let result = ((try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: AnyObject]) as [String: AnyObject]??) {
            printIfDebug("Body: \(String(describing: result))")
        } else if let httpBody = request.request?.httpBody, let resultString = String(data: httpBody, encoding: .utf8) {
            printIfDebug("Body: \(String(describing: resultString))")
        }
    }
    
    public func log(request: URLRequest) {
        print("-------------")
        print("Request: \(request.url!)")
        print("Headers: \(request.allHTTPHeaderFields!)")
        print("Method: \(request.httpMethod!)")
        if let httpBody = request.httpBody, let result = ((try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: AnyObject]) as [String: AnyObject]??) {
            printIfDebug("Body: \(String(describing: result))")
        } else if let httpBody = request.httpBody, let resultString = String(data: httpBody, encoding: .utf8) {
            printIfDebug("Body: \(String(describing: resultString))")
        }
    }

    public func log(response: AFDataResponse<Data?>) {
        if let request = response.request {
            log(request: request)
        }
        printIfDebug("Code: \(String(describing: response.response?.statusCode))")
        guard let data = response.data else { return }
        if let dataDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            printIfDebug("ResponseData: \(String(describing: dataDict))")
        } else if let stringData = String(data: data, encoding: .utf8) {
            printIfDebug(stringData)
        }
    }

    public func log(error: Error) {
        printIfDebug("\(error)")
    }
}

func printIfDebug(_ string: String) {
    #if DEBUG
    print(string)
    #endif
}
