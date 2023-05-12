import Foundation

var tasks: [String: String] = [:]

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

showTasks()

print("\n")
// Interface do programa
func showMenu() {
    print("--------------------------- 📓 MENU --------------------------" )
    print("1. Criar nova tarefa")
    print("2. Editar tarefa")
    print("3. Excluir tarefa")
    print("4. Exibir Tarefas")
    print("5. Concluir uma tarefa")
    print("6. Fechar programa")
    print("---------------------------------------------------------------")
    
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
            completeTask()
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
