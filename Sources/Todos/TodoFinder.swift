//
//  File.swift
//  
//
//  Created by Florian Heiber on 14.06.2020.
//

import Foundation

class TodoFinder {
    static let keyword = "// TODO:"

    static func getTodoLines(in file: File) -> [Line] {
        var result = [Line]()

        for line in file.content {
            if line.qualifies(for: keyword) {
                result.append(cleaned(line: line))
            }
        }

        return result
    }

    static func cleaned(line: Line) -> Line {
        // TODO: Replace this with Regex
        let trimmed = line.content
            .replacingOccurrences(of: keyword, with: "")
            .trimmingCharacters(in: .whitespaces)
        return Line(number: line.number, content: trimmed)
    }
}
