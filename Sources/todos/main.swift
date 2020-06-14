import ShellOut

func getTodos() -> String? {
    let gitCommands = [
        "git diff --name-only",
        "git diff --name-only --staged",
        "git ls-files --other --exclude-standard"
    ]

    do {
        let files = try shellOut(to: gitCommands)
    } catch {
        let error = error as! ShellOutError
        print(error.localizedDescription)
    }

    return ""
}

let result = getTodos()
print(result)
