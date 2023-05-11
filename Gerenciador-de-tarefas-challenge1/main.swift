import Foundation

var tasks: [String: String] = [:]

func addNewTask() {
    print("Digite o título da nova tarefa:")
    guard let titulo = readLine() else {
        return print("Título inválido.")}
    print("Digite a descrição da nova tarefa:")
    guard let descricao = readLine() else {
        return print("Descrição inválida.")}
    tasks[titulo] = descricao
    print("Tarefa adicionada: \(titulo)")
    print("\n")
    showTasks()
}


func editTask() {
    print("Digite o título da tarefa que deseja editar:")
    guard let titulo = readLine() else {
        return print("Título inválido.")}
    print("Digite a nova descrição da tarefa:")
    guard let novaDescricao = readLine() else {
        return print("Nova descrição inválida.")}
    if tasks.keys.contains(titulo) {
        tasks[titulo] = novaDescricao
        print("Tarefa editada: \(titulo)")
    } else {
        print("Tarefa não encontrada.")
    }
    showTasks()
}

func removeTask() {
    print("Digite o título da tarefa que deseja remover:")
    guard let titulo = readLine() else {
        return print("Título inválido.")
    }
    guard let _ = tasks.removeValue(forKey: titulo) else {
        return print("Tarefa não encontrada.")
    }
    print("Tarefa removida: \(titulo)")
    showTasks()
}

func showTasks() {
    print("------------------------- 📝 Tarefas ------------------------")
    if tasks.isEmpty {
        print("Nenhuma tarefa encontrada.")
    } else {
        for (titulo, descricao) in tasks {
            print("- \(titulo): \(descricao)")
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
        print("Erro ao salvar tasks: \(error.localizedDescription)")
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
//    var NewTitle: String = "✅ (titulo)"
//    tasks[NewTitle] = description
//    tasks.removeValue(forKey: title)
    showTasks()
}
let nomeArquivo = "tarefas.json"
let desktopURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first
let fileURL = desktopURL?.appendingPathComponent(nomeArquivo)
if let data = try? Data(contentsOf: fileURL!),
   let tarefasSalvas = try? JSONDecoder().decode([String: String].self, from: data) {
    tasks = tarefasSalvas
    // print("tasks carregadas do arquivo.")
} else {
    print("Nenhum arquivo de tasks encontrado.")
}


// print("------------------------- 📝 Tarefas ------------------------")
showTasks()
print("------------------------- FIM DA LISTA -----------------------")
print("\n")
// Interface do programa
func showMenu() {
    print("--------------------------- 📓 MENU ---------------------------")
    print("1. Criar nova tarefa")
    print("2. Editar tarefa")
    print("3. Excluir tarefa")
    print("4. Exibir Tarefas")
    print("5. Concluir uma tarefa")
    print("6. Fechar programa")
    print("--------------------------------------------------------------")

    if let opcao = readLine(), let escolha = Int(opcao) {
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
