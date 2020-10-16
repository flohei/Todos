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
        let fileContent = try String(contentsOfFile: filePath, encoding: .utf8)
        let lines = fileContent.components(separatedBy: .newlines)

        let lineElements = lines
            .enumerated()
            .map { Line(number: $0 + 1, content: String($1)) }

        content = lineElements
    }
}

extension File: CustomDebugStringConvertible {
    var debugDescription: String {
        return "File \(name) consisting of \(content.count) lines"
    }
}
