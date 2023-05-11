import Foundation

var tarefas: [String: String] = [:] // Dicionário vazio para armazenar as tarefas

func adicionarTarefa() {
    print("Digite o título da nova tarefa:")
    if let titulo = readLine() {
        print("Digite a descrição da nova tarefa:")
        if let descricao = readLine() {
            tarefas[titulo] = descricao
            print("Tarefa adicionada: \(titulo)")
        } else {
            print("Descrição inválida.")
        }
    } else {
        print("Título inválido.")
    }
    exibirTarefas()
}

func editarTarefa() {
    print("Digite o título da tarefa que deseja editar:")
    if let titulo = readLine() {
        print("Digite a nova descrição da tarefa:")
        if let novaDescricao = readLine() {
            if tarefas.keys.contains(titulo) {
                tarefas[titulo] = novaDescricao
                print("Tarefa editada: \(titulo)")
            } else {
                print("Tarefa não encontrada.")
            }
        } else {
            print("Nova descrição inválida.")
        }
    } else {
        print("Título inválido.")
    }
    exibirTarefas()
}

func removerTarefa() {
    print("Digite o título da tarefa que deseja remover:")
    if let titulo = readLine() {
        if let _ = tarefas.removeValue(forKey: titulo) {
            print("Tarefa removida: \(titulo)")
        } else {
            print("Tarefa não encontrada.")
        }
    } else {
        print("Título inválido.")
    }
    exibirTarefas()
}

func exibirTarefas() {
    print("\nTarefas cadastradas:")
    if tarefas.isEmpty {
        print("Nenhuma tarefa encontrada.")
    } else {
        for (titulo, descricao) in tarefas {
            print("- \(titulo): \(descricao)")
        }
    }
    print("\n")
}

func salvarTarefas(_ nomeArquivo: String) {
    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(tarefas)
        let desktopURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first
        let fileURL = desktopURL?.appendingPathComponent(nomeArquivo)
        try data.write(to: fileURL!)
    } catch {
        print("Erro ao salvar tarefas: \(error.localizedDescription)")
    }
}

// Verificar se existe um arquivo com as tarefas salvas
let nomeArquivo = "tarefas.json"
let desktopURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first
let fileURL = desktopURL?.appendingPathComponent(nomeArquivo)
if let data = try? Data(contentsOf: fileURL!),
   let tarefasSalvas = try? JSONDecoder().decode([String: String].self, from: data) {
    tarefas = tarefasSalvas
    // print("Tarefas carregadas do arquivo.")
} else {
    print("Nenhum arquivo de tarefas encontrado.")
}


print("------------------------- 📝 Tarefas ------------------------")
exibirTarefas()
print("------------------------- FIM DA LISTA -----------------------")
print("\n")
// Interface do programa
func exibirMenu() {
    print("--------------------------- 📓 MENU ---------------------------")
    print("1. Criar nova tarefa")
    print("2. Editar tarefa")
    print("3. Excluir tarefa")
    print("4. Exibir tarefas")
    print("5. Fechar programa")
    print("--------------------------------------------------------------")

    if let opcao = readLine(), let escolha = Int(opcao) {
        switch escolha {
        case 1:
            adicionarTarefa()
        case 2:
            editarTarefa()
        case 3:
            removerTarefa()
        case 4:
            exibirTarefas()
        case 5:
            salvarTarefas(nomeArquivo)
            print("Tarefas salvas. O programa será fechado.")
            return
        default:
            print("Opção inválida.")
        }
    } else {
        print("Opção inválida.")
    }

    exibirMenu() // Chamar novamente o menu para exibir as opções novamente
}

// Iniciar o programa
//exibirTarefas()
exibirMenu()
