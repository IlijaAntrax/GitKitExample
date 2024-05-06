//
//  String+.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 6.5.24..
//

import Foundation

extension String {
    func toDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: self) {
            let localFormatter = DateFormatter()
            localFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
            return localFormatter.string(from: date)
        } else { return nil }
    }
}
