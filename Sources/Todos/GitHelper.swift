//
//  GitHelper.swift
//
//
//  Created by Florian Heiber on 14.06.2020.
//

import Foundation
import ShellOut

fileprivate extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}

struct GitHelper {
    /// Retrieves all files currently not committed in the user's working copy. These include staged and unstaged changes as well as files that have not yet been git-added.
    /// - Returns: An array of file paths relative to the current working directory
    static func getModifiedFiles() -> [String] {
        // TODO: Consider make this throwing

        let gitCommands = [
            "git diff --name-only",
            "git diff --name-only --staged",
            "git ls-files --other --exclude-standard"
        ]

        var gitResult: String?

        do {
            gitResult = try shellOut(to: gitCommands)
        } catch {
            let error = error as! ShellOutError
            print(error.localizedDescription)
        }

        let paths = gitResult?.split(separator: "\n").map { String($0) }

        return paths?.unique() ?? []
    }
}
