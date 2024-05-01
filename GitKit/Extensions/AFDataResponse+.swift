//
//  AFDataResponse+.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation
import Alamofire

extension AFDataResponse {
    
    var hasSuccessStatusCode: Bool {
        if let response = response {
            return 200...299 ~= response.statusCode
        }
        return false
    }
    
    var hasUnauthorizedStatusCode: Bool {
        if let response = response {
            return response.statusCode == 401
        }
        return false
    }
    
    var hasNotFoundCode: Bool {
        if let response = response {
            return response.statusCode == 404
        }
        return false
    }
}
