//
//  FormView.swift
//  TripData
//
//  Created by Gustavo Assis on 08/10/23.
//

import SwiftUI

struct FormView: View {
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var nome: String = ""
    @State private var data: Date = .now
    @State private var detalhe: String = ""
    @State private var prioridade: Int = 2
    
    @Binding var editando: Bool
    @Bindable var destino: Destino
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Destino", text: editando ?  $destino.nome :  $nome)
                TextField("Detalhes", text: editando ? $destino.detalhe : $detalhe, axis: .vertical)
                DatePicker("Date", selection: editando ? $destino.data : $data)
                
                Section("Prioridade"){
                    Picker("Nivel de prioridade", selection: editando ? $destino.prioridade : $prioridade){
                        Text("Baixo").tag(1)
                        Text("Médio").tag(2)
                        Text("Alto").tag(3)
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Novo destino")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Salvar"){
                        
                        if !editando && nome != "" {
                            let destino = Destino(nome: nome, detalhe: detalhe, data: data, prioridade: prioridade)
                            context.insert(destino)
                            dismiss()
                        } else {
                            dismiss()
                            editando = false
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    FormView()
//}
