//
//  AddTaskView.swift
//  Session9
//
//  Created by DAMII on 17/12/24.
//

import SwiftUI

struct AddTaskView: View {
    @ObservedObject var viewModel: TaskViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var isLoading: Bool = true
    
    var body: some View {
        NavigationView {
            if isLoading {
                ProgressView("Cargando listas")
                    .onAppear {
                        Task {
                            await viewModel.ferchOptions()
                            isLoading = false
                        }
                    }
            } else {
                Form {
                    Section(header: Text("Información de la tarea")) {
                        TextField("Nombre", text: $viewModel.name)
                        TextField("Descripción", text: $viewModel.descripcion)
                    }
                    
                    Section(header: Text("Prioridad")) {
                        Picker("Seleccionar prioridad", selection: $viewModel.selectPriority) {
                            ForEach(viewModel.listPriorities, id: \.self) { item in
                                Text(item.name).tag(item as Priority?)
                            }
                        }
                    }
                    
                    Section(header: Text("Categoría")) {
                        Menu {
                            ForEach(viewModel.listCategories) { item in
                                Button(action: {
                                    viewModel.selectCategories = item
                                } , label: {
                                    HStack {
                                        Text(item.name)
                                        if item == viewModel.selectCategories {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.blue)
                                        }
                                    }
                                } )
                            }
                        } label: {
                            
                            HStack {
                                Text("Selecionar categorias")
                                Spacer()
                                Text(viewModel.selectCategories?.name ?? "Ninguna")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    Section(header: Text("Etiqueta")) {
                        NavigationLink(destination: SearchTagView (
                            tagList: viewModel.listTags,
                            selectedTag: $viewModel.selectTag
                        )) {
                            Text("Seleccionar etiqueta")
                            Spacer()
                            Text(viewModel.selectTag?.name ?? "Ninguna")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .navigationTitle("Nueva tarea")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Guardar") {
                            viewModel.createTask()
                            viewModel.resetFields()
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") {
                            viewModel.resetFields()
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
