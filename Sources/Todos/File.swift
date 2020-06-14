//
//  File.swift
//  
//
//  Created by Florian Heiber on 14.06.2020.
//

import Foundation

struct File {
    let name: String
    let content: [Line]

    init?(filePath: String) throws {
        name = filePath
        content = try String(contentsOfFile: filePath)
            .split(separator: "\n")
            .enumerated()
            .map { Line(number: $0 + 1, content: String($1)) }
    }
}

extension File: CustomDebugStringConvertible {
    var debugDescription: String {
        return "File \(name) with \(content.count) lines"
    }
}
