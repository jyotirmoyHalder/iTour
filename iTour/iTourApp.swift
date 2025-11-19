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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
