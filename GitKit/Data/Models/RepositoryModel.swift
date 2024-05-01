//
//  RepositoryModel.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

struct RepositoryModel: Decodable {
    let id: Int?
    let name: String?
    let fullName: String?
    let language: String?
    let defaultBranch: String?
}
