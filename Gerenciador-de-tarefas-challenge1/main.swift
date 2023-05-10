//
//  main.swift
//  Gerenciador-de-tarefas-challenge1
//
//  Created by userext on 09/05/23.
//

import Foundation

var tarefas: [String : String] = [:]
var count: Int = 1
var aux = 1

func adicionar() {
    print("Digite o título:")
    var title: String = readLine() ?? " "
    print("Digite a descrição da tarefa:")
    var description = readLine() ?? "  "

    tarefas[title] = description
    count += 1
}

func remover (key: String) {
    tarefas.removeValue(forKey: key)
}

func listar() {

}

adicionar()
adicionar()
//print(tarefas[1]?.titulo)

// print(tarefas.values)

while (aux == 1){
    
    
}
