import Foundation

// TODO: Organize code structure
// TODO: Only look for TODOs in changed chunks, not the entire file

func printTodos(_ todos: [Line]) {
    for todoLine in todos {
        print("- [ ] Line \(todoLine.number): \(todoLine.content)")
    }
}

let filePaths = GitHelper.getModifiedFiles()
let files = filePaths.compactMap { try? File(filePath: $0) }

for file in files {
    let todos = TodoFinder.getTodoLines(in: file)

    if !todos.isEmpty {
        print("Found TODOs in \(file.name):")
        printTodos(todos)
    }
}
