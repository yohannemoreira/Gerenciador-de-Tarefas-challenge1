import Foundation

func addNewTask() {
    print("Digite o título da nova tarefa:")
    guard let title = readLine() else {
        return print("Título inválido.")}
    print("Digite a descrição da nova tarefa:")
    guard let description = readLine() else {
        return print("Descrição inválida.")}
    tasks[title] = description
    print("Tarefa adicionada: \(title)")
    print("\n")
    showTasks()
}


func editTask() {
    print("Digite o título da tarefa que deseja editar:")
    guard let title = readLine() else {
        return print("Título inválido.")}
    print("Digite a nova descrição da tarefa:")
    guard let newDescription = readLine() else {
        return print("Nova descrição inválida.")}
    if tasks.keys.contains(title) {
        tasks[title] = newDescription
        print("Tarefa editada: \(title)")
    } else {
        print("Tarefa não encontrada.")
    }
    print("\n")
    showTasks()
}

func removeTask() {
    print("Digite o título da tarefa que deseja remover:")
    guard let title = readLine() else {
        return print("Título inválido.")
    }
    guard let _ = tasks.removeValue(forKey: title) else {
        return print("Tarefa não encontrada.")
    }
    print("Tarefa removida: \(title)")
    print("\n")
    showTasks()
}

func showTasks() {
    print("------------------------- 📝 Tarefas ------------------------")
    if tasks.isEmpty {
        print("Nenhuma tarefa encontrada.")
    } else {
        for (title, description) in tasks {
            print("- \(title): \(description)")
        }
    }
    print("-----------------------▪️FIM DA LISTA▪️----------------------")
    print("\n")
}

func saveTasks(_ nomeArquivo: String) {
    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(tasks)
        let desktopURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first
        let fileURL = desktopURL?.appendingPathComponent(nomeArquivo)
        try data.write(to: fileURL!)
    } catch {
        print("Erro ao salvar tarefas: \(error.localizedDescription)")
    }
}

func completeTask () {
    print("Digite o título da tarefa que deseja marcar como concluída:")
    guard let title = readLine() else {
        return print("Essa tarefa não existe")
    }
    guard let description = tasks[title] else {
        return print("Ocorreu um erro")
    }
    tasks.updateValue( "\(description) | ✅", forKey: title)
    //    var NewTitle: String = "✅ (tittle)"
    //    tasks[NewTitle] = description
    //    tasks.removeValue(forKey: title)catc
    print("\n")
    showTasks()
}
