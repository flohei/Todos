import Foundation

// TODO: Organize code structure
// TODO: Only look for TODOs in changed chunks, not the entire file
// TODO: Add ignore list
// TODO: Add option to read ignore list from Todosfile
// TODO: Add an option to list all todos, regardless of the git state

func printTodos(_ todos: [Line]) {
    for todoLine in todos {
        print("\t✔ Line \(todoLine.number): \(todoLine.content)")
    }
}

let filePaths = GitHelper.getModifiedFiles()
let files = filePaths.compactMap { try? File(filePath: $0) }

for file in files {
    let todos = TodoFinder.getTodoLines(in: file)

    if !todos.isEmpty {
        print("📄 \(file.name):")
        printTodos(todos)
    }
}
