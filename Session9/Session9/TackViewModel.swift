//
//  TaskViewModel.swift
//  Session9
//
//  Created by DAMII on 17/12/24.
//

import Foundation
import CoreData

class TaskViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var descripcion: String = ""
    @Published var completado: Bool = false
    @Published var selectPriority: Priority? = nil
    @Published var selectTag: Tag? = nil
    @Published var selectCategories: Category? = nil
    
    @Published var listPriorities: [Priority] = []
    @Published var listCategories: [Category] = []
    @Published var listTags: [Tag] = []
    
    @Published var tasks: [Tarea] = []
    
    let viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchTasks()
    }
    
    func ferchOptions() async {
        do {
            self.listPriorities = try await AppServices.shared.getListPriorities()
            self.listCategories = try await AppServices.shared.getListCategories()
            self.listTags = try await AppServices.shared.getListTags()
        } catch {
            print("Error al cargar listas: \(error.localizedDescription)")
        }
    }
    
    func fetchTasks() {
        let request: NSFetchRequest<Tarea> = Tarea.fetchRequest()
        do {
            tasks = try viewContext.fetch(request)
        } catch {
            print("Error al cargar tareas: \(error.localizedDescription)")
        }
    }
    
    func createTask() {
        let newTask = Tarea(context: viewContext)
        newTask.id = UUID()
        newTask.nombre = name
        newTask.descripcion = descripcion
        newTask.categoria = selectCategories?.name ?? "N/A"
        newTask.prioridad = selectPriority?.name ?? "N/A"
        newTask.etiqueta = selectTag?.name ?? "N/A"
        newTask.completado = false
        confirmSave()
        fetchTasks()
    }
    
    func deleteTask(_ task: Tarea) {
        viewContext.delete(task)
        confirmSave()
        fetchTasks()
    }
    
    func toggleCompletion(for task: Tarea) {
        task.completado.toggle()
        confirmSave()
        fetchTasks()
    }
    
    private func confirmSave() {
        do {
            try viewContext.save()
        } catch {
            print("Error al guardar los cambios: \(error.localizedDescription)")
        }
    }
    
    func resetFields() {
        name = ""
        descripcion = ""
        selectPriority = nil
        selectTag = nil
        selectCategories = nil
    }
}
