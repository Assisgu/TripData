//
//  TripDataApp.swift
//  TripData
//
//  Created by Gustavo Assis on 08/10/23.
//

import SwiftUI
import SwiftData

@main
struct TripDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destino.self)
    }
}
