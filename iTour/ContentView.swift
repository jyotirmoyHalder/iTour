//
//  ContentView.swift
//  iTour
//
//  Created by jyotirmoy_halder on 18/11/25.
//

import SwiftData
import SwiftUI


struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [Destination]()
    @State private var sortOrder = SortDescriptor(\Destination.name)
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder, searchString: searchText)
                .navigationTitle("iTour")
                .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .toolbar {
    //                ToolbarItem(placement: .topBarTrailing) {
    //                    Button("Add Samples", action: addSamples)
    //                }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Destination", systemImage: "plus", action: addDestination)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder) {
                                Text("Name")
                                    .tag(SortDescriptor(\Destination.name))
                                
                                Text("Priority")
                                    .tag(SortDescriptor(\Destination.priority, order: .reverse))
                                
                                Text("Date")
                                    .tag(SortDescriptor(\Destination.date))
                            }
                            .pickerStyle(.inline)
                        }
                    }
                }
        }
    }
    
    /*
    func addSamples() {
        let rome = Destination(
            name: "Rome",
            details: "The Eternal City with ancient ruins and vibrant street life.",
            date: Date(),
            priority: 1
        )
        let florence = Destination(
            name: "Florence",
            details: "Renaissance art and architecture, home to the Duomo and Uffizi.",
            date: Date(),
            priority: 2
        )
        let naples = Destination(
            name: "Naples",
            details: "Coastal city famous for pizza and proximity to Pompeii.",
            date: Date(),
            priority: 3
        )

        modelContext.insert(rome)
        modelContext.insert(florence)
        modelContext.insert(naples)
    }
     
     */
    
//    func deleteDestinations(_ indexSet: IndexSet) {
//        for index in indexSet {
//            let destination = destinations[index]
//            modelContext.delete(destination)
//        }
//    }
    
    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
    
   
}

#Preview {
    ContentView()
}
