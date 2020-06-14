import Foundation
import ShellOut

// TODO: Organize code structure
// TODO: Only look for TODOs in changed chunks, not the entire file

/// Retrieves all files currently not committed in the user's working copy. These include staged and unstaged changes as well as files that have not yet been git-added.
/// - Returns: An array of file paths relative to the current working directory
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

func printTodos(_ todos: [Line]) {
    for todoLine in todos {
        print("- [ ] Line \(todoLine.number): \(todoLine.content)")
    }
}

let filePaths = getModifiedFiles()
let files = filePaths
    .compactMap { try? File(filePath: $0) }
    .filter { !$0.content.isEmpty }

for file in files {
    print("Found TODOs in \(file.name):")
    let todos = TodoFinder.getTodoLines(in: file)
    printTodos(todos)
}
