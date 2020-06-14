import Foundation
import ShellOut

func getModifiedFiles() -> [String] {
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

    return gitResult?.split(separator: "\n").map { String($0) } ?? []
}

func getTodos() -> String? {
    let modifiedFiles = getModifiedFiles()
    print(modifiedFiles)

    // TODO: grep over all files for TODO and FIXME

    return "git"
}

let todos = getTodos()
print(todos)
