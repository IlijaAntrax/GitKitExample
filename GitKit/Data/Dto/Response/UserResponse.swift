//
//  UserResponse.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

struct UserResponse: Codable {
    let login: String?
    let id: Int?
    let node_id: String?
    let avatar_url: String?
    let organizations_url: String?
    let repos_url: String?
    let events_url: String?
    let type: String?
    let name: String?
    let company: String?
    let email: String?
    let public_repos: Int?
}

extension UserResponse: DtoMappable {
    typealias Model = UserModel
    func mapTo() -> UserModel? {
        return UserModel(username: self.login,
                         avatarUrl: self.avatar_url,
                         fullName: self.name,
                         company: self.company,
                         email: self.email)
    }
}
