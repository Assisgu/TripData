//
//  Destino.swift
//  TripData
//
//  Created by Gustavo Assis on 08/10/23.
//

import Foundation
import SwiftData

@Model
class Destino {
    var nome: String
    var detalhe: String
    var data: Date
    var prioridade: Int
    
    init(nome: String = "", detalhe: String = "", data: Date = .now, prioridade: Int = 2) {
        self.nome = nome
        self.detalhe = detalhe
        self.data = data
        self.prioridade = prioridade
    }
}
