//
//  CommitModel.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

struct CommitModel: Decodable {
    let message: String?
    let authorName: String?
    let authorEmail: String?
    let date: String?
}
