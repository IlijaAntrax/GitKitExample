//
//  UserModel.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

struct UserModel: Decodable {
    let username: String?
    let avatarUrl: String?
    let fullName: String?
    let company: String?
    let email: String?
}
