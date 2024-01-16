//
//  ContentView.swift
//  TripData
//
//  Created by Gustavo Assis on 08/10/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query(sort: [ SortDescriptor(\Destino.prioridade, order: .reverse),
                   SortDescriptor(\Destino.nome)] ) var destinos: [Destino]
    
    @Environment(\.modelContext) var context
    
    @State private var editando: Bool = false
    @State private var destinoAtual: Destino?
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(destinos){ destino in
                     CelulaView(destino: destino)
                        .onTapGesture {
                            editando = true
                            destinoAtual = destino
                        }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(destinos[index])
                    }
                }
            }
            .navigationTitle("Destinos")
            .sheet(item: $destinoAtual) { destino in
                FormView(editando: $editando, destino: destino)
            }
            
            .toolbar{
                NavigationLink(destination: FormView(editando: $editando, destino: Destino() )) {
                    Image(systemName: "plus.circle")
                }
            }
            
            .overlay{
                if destinos.isEmpty {
                    ContentUnavailableView(label: {
                        Label("Você não possui destinos", systemImage: "airplane.departure").foregroundStyle(.blue) },
                            description: { Text("Hmm que tal adicionar uma viagem ?") },
                            actions: {
                        NavigationLink(destination: FormView(editando: $editando, destino: Destino() ), label: {
                            Text("Novo destino")
                        })
                    }
                    
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

struct CelulaView: View {
    @State var destino = Destino()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text(destino.nome)
                    .font(.headline)
                HStack{
                    Image(systemName: "calendar.circle")
                    Text(destino.data.formatted(date: .long, time: .shortened))
                }
                .font(.subheadline)
                .foregroundStyle(.gray)
                .padding(.top, 2)
            }
            Spacer()
            VStack{
                Text("Prioridade")
                    .font(.system(size: 10))
                    .foregroundStyle(.gray)
                    .padding(.vertical, 1)
                
                Image(systemName: setarCor(destino.prioridade).imageName)
                    .font(.title2)
                    .foregroundStyle(setarCor(destino.prioridade).color)
            }
        }
        
    }
    
    func setarCor(_ prioridade: Int) -> (imageName: String, color: Color) {
        switch prioridade {
        case 3:
            return ("star.fill", .blue)
        case 2:
            return ("star.leadinghalf.filled", .yellow)
        case 1:
            return ("star", .gray)
        default:
            return ("", .black)
        }
    }
}

