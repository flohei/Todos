//
//  File.swift
//  
//
//  Created by Florian Heiber on 14.06.2020.
//

import Foundation

class TodoFinder {
    static func getTodoLines(in file: File) -> [Line] {
        // let keywords = ["TODO", "FIXME"]
        let keyword = "// TODO:"

        var result = [Line]()

        for line in file.content {
            if line.qualifies(for: keyword) {
                result.append(line)
            }
        }

        return result
    }

    static func cleaned(line: String) -> String {
        return line.trimmingCharacters(in: .whitespaces)
    }
}
