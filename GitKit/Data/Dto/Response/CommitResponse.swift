//
//  CommitResponse.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

struct CommitResponse: Codable {
    let node_id: String?
    let url: String?
    let commit: SingleCommitResponse?
}

struct SingleCommitResponse: Codable {
    let message: String?
    let author: CommitAuthorResponse?
}

struct CommitAuthorResponse: Codable {
    let name: String?
    let email: String?
    let date: String?
}

extension CommitResponse: DtoMappable {
    typealias Model = CommitModel
    func mapTo() -> CommitModel? {
        return CommitModel(message: commit?.message,
                           authorName: commit?.author?.name,
                           authorEmail: commit?.author?.email,
                           date: commit?.author?.date)
    }
}
