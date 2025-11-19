//
//  iTourApp.swift
//  iTour
//
//  Created by jyotirmoy_halder on 18/11/25.
//

import SwiftData
import SwiftUI

@main
struct iTourApp: App {
    
    let container: ModelContainer = {
        let schema = Schema([Expense.self, Destination.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            ContentViewSecond()
        }
//        .modelContainer(for: [Destination.self, Expense.self])
        .modelContainer(container)
    }
}
