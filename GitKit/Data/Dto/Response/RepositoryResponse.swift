//
//  RepositoryResponse.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

struct RepositoryResponse: Codable {
    let id: Int?
    let node_id: String?
    let name: String?
    let full_name: String?
    let url: String?
    let language: String?
    let default_branch: String?
}

extension RepositoryResponse: DtoMappable {
    typealias Model = RepositoryModel
    func mapTo() -> RepositoryModel? {
        return RepositoryModel(id: id,
                               name: name,
                               fullName: full_name,
                               language: language,
                               defaultBranch: default_branch)
    }
}
