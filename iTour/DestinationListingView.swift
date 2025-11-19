//
//  DestinationListingView.swift
//  iTour
//
//  Created by jyotirmoy_halder on 19/11/25.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse), SortDescriptor(\Destination.name, order: .forward)]) var destinations: [Destination]
    
    var body: some View {
        List {
            ForEach(destinations) { destination in
                NavigationLink(value: destination) {
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        
                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .onDelete(perform: deleteDestinations)
        }
    }
    
    init(sort: SortDescriptor<Destination>, searchString: String) {
        _destinations = Query(
            filter: #Predicate<Destination> { destination in
                if searchString.isEmpty {
                    return true
                } else {
                    return destination.name.localizedStandardContains(searchString)
                    || destination.details.localizedStandardContains(searchString)
                    || destination.sights.contains{ sight in
                        sight.name.localizedStandardContains(searchString)
                    }
                }
        }, sort: [sort])
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        let itemsToDelete = indexSet.map { destinations[$0] }
        for item in itemsToDelete {
            modelContext.delete(item)
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "")
}
