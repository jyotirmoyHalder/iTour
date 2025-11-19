//
//  EditDestinationView.swift
//  iTour
//
//  Created by jyotirmoy_halder on 19/11/25.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
    
    @Bindable var destination: Destination
    @Environment(\.modelContext) private var modelContext
    @State private var newSightName = ""
    
    @Environment(\.dismiss) private var dismiss
    @State private var showDiscardAlert = false
    
    var body: some View {
        Form {
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details, axis: .vertical)
            DatePicker("Date", selection: $destination.date)
            
            Section("Priority") {
                Picker("Priority", selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.segmented)
            }
            
            Section("Sights") {
                ForEach(destination.sights) { sight in
                    Text(sight.name)
                }
                .onDelete(perform: deleteSights)
                
                HStack {
                    TextField("Add a new sight in \(destination.name)", text: $newSightName)
                    
                    Button("Add", action: addSight)
                }
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    let trimmed = destination.name.trimmingCharacters(in: .whitespacesAndNewlines)
                    if trimmed.isEmpty {
                        showDiscardAlert = true
                    } else {
                        dismiss()
                    }
                } label: {
                    Label("Back", systemImage: "chevron.left")
                }
            }
        }
        .alert("Discard changes?", isPresented: $showDiscardAlert) {
            Button("Cancel", role: .cancel) {
                // Stay on the page; do nothing
            }
            Button("Discard", role: .destructive) {
                // Delete and dismiss
                modelContext.delete(destination)
                dismiss()
            }
        } message: {
            Text("The destination has an empty name. Do you want to discard it?")
        }
    }
    
    func addSight() {
        guard newSightName.isEmpty == false else { return }
        
        withAnimation {
            let sight = Sight(name: newSightName)
            destination.sights.append(sight)
            newSightName = ""
        }
    }
    
    func deleteSights(_ indexSet: IndexSet) {
        withAnimation {
            // Collect the sights to delete based on the provided indices
            let sightsToDelete = indexSet.map { destination.sights[$0] }
            
            // Remove from the relationship array first (keeps UI in sync)
            destination.sights.remove(atOffsets: indexSet)
            
            // If Sight is a @Model, also remove them from the model context
            for sight in sightsToDelete {
                modelContext.delete(sight)
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(
            name: "Naples",
            details: "Coastal city famous for pizza and proximity to Pompeii.",
            date: Date(),
            priority: 3
        )
        return EditDestinationView(destination: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}

