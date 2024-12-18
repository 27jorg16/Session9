//
//  TaskListView.swift
//  Session9
//
//  Created by DAMII on 17/12/24.
//

import SwiftUI

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel = TaskViewModel(context: PersistenceController.shared.container.viewContext)
    
    @State private var isAddTask = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks) { task in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(task.nombre ?? "Sin nombre")
                                .font(.headline)
                            Text(task.descripcion ?? "Sin descripción")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Button(action: {
                            viewModel.toggleCompletion(for: task)
                        }) {
                            Image(systemName: task.completado ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.completado ? .green : .gray)
                        }
                    }
                    .opacity(task.completado ? 0.5 : 1.0)
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        viewModel.deleteTask(viewModel.tasks[index])
                    }
                }
            }
            .navigationTitle("Mis tareas")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        isAddTask = true
                    }) {
                        Label("Agregar", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddTask) {
                AddTaskView(viewModel: viewModel)
            }
        }
    }
}
