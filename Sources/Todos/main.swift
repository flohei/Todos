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

func grepTodo(in file: String) -> String? {
    let grepCommand = "grep -E -C2 'TODO|FIXME'"
    return try? shellOut(to: grepCommand, arguments: [file])
}

func getTodos() -> [String: String] {
    let modifiedFiles = getModifiedFiles()

    var todos = [String: String]()

    for file in modifiedFiles {
        guard let issues = grepTodo(in: file) else { continue }
        todos[file] = issues
    }

    return todos
}

let todos = getTodos()

todos.forEach { (file, issues) in
    print("Todos found in \(file):\n")
    print(issues)
}
