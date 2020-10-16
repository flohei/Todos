//
//  File.swift
//  
//
//  Created by Florian Heiber on 14.06.2020.
//

import Foundation

class TodoFinder {
    static let keywords = ["TODO", "FIXME"]
    static let keyword = "// TODO:"

    static func getTodoLines(in file: File) -> [Line] {
        var result = [Line]()

        // Get all the lines that contain any of our keywords
        let relevantLines = file.content.filter { $0.qualifies(for: keyword) }

        // Cleanup those lines to provide for a nice print-out
        let cleanedLines = relevantLines.map { cleaned(line: $0) }

        result.append(contentsOf: cleanedLines)

        return result
    }

    static func cleaned(line: Line) -> Line {
        let pattern = "//\\s*(\(keywords.joined(separator: "|"))):\\s*(.*)"
        let groups = line.content.groups(for: pattern)

        // First group is either TODO or FIXME. Take second group of first match.
        guard let trimmed = groups.first?[2] else {
            print("Regex didn't match, returning original line")
            return line
        }

        return Line(number: line.number, content: trimmed)
    }
}
