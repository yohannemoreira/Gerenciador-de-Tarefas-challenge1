import Foundation
//import Rainbow

var tasks: [String: String] = [:]

func addNewTask() {
    print("Digite o título da nova tarefa:")
    guard let tittle = readLine() else {
        return print("Título inválido.")}
    print("Digite a descrição da nova tarefa:")
    guard let description = readLine() else {
        return print("Descrição inválida.")}
    tasks[tittle] = description
    print("Tarefa adicionada: \(tittle)")
    print("\n")
    showTasks()
}


func editTask() {
    print("Digite o título da tarefa que deseja editar:")
    guard let tittle = readLine() else {
        return print("Título inválido.")}
    print("Digite a nova descrição da tarefa:")
    guard let novadescription = readLine() else {
        return print("Nova descrição inválida.")}
    if tasks.keys.contains(tittle) {
        tasks[tittle] = novadescription
        print("Tarefa editada: \(tittle)")
    } else {
        print("Tarefa não encontrada.")
    }
    print("\n")
    showTasks()
}

func removeTask() {
    print("Digite o título da tarefa que deseja remover:")
    guard let tittle = readLine() else {
        return print("Título inválido.")
    }
    guard let _ = tasks.removeValue(forKey: tittle) else {
        return print("Tarefa não encontrada.")
    }
    print("Tarefa removida: \(tittle)")
    print("\n")
    showTasks()
}

func showTasks() {
    print("------------------------- 📝 Tarefas ------------------------")
    if tasks.isEmpty {
        print("Nenhuma tarefa encontrada.")
    } else {
        for (tittle, description) in tasks {
            print("- \(tittle): \(description)")
        }
    }
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

func CompleteTask () {
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
//    tasks.removeValue(forKey: title)
    print("\n")
    showTasks()
}
let nomeArquivo = "tarefas.json"
let desktopURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first
let fileURL = desktopURL?.appendingPathComponent(nomeArquivo)
if let data = try? Data(contentsOf: fileURL!),
   let savedTasks = try? JSONDecoder().decode([String: String].self, from: data) {
    tasks = savedTasks
    // print("tasks carregadas do arquivo.")
} else {
    print("Nenhum arquivo de tarefas encontrado.")
}


// print("------------------------- 📝 Tarefas ------------------------")
showTasks()
print("------------------------- FIM DA LISTA -----------------------")
print("\n")
// Interface do programa
func showMenu() {
    print("--------------------------- 📓 MENU ---------------------------" )
    print("1. Criar nova tarefa")
    print("2. Editar tarefa")
    print("3. Excluir tarefa")
    print("4. Exibir Tarefas")
    print("5. Concluir uma tarefa")
    print("6. Fechar programa")
    print("--------------------------------------------------------------")

    if let option = readLine(), let escolha = Int(option) {
        switch escolha {
        case 1:
            addNewTask()
        case 2:
            editTask()
        case 3:
            removeTask()
        case 4:
            showTasks()
        case 5:
            CompleteTask()
        case 6:
            saveTasks(nomeArquivo)
            print("Tarefas salvas. O programa será fechado.")
            return
        default:
            print("Opção inválida.")
        }
    } else {
        print("Opção inválida.")
    }
    showMenu()
}
showMenu()
