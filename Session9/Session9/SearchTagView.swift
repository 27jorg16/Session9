//
//  SearchTagView.swift
//  Session9
//
//  Created by DAMII on 17/12/24.
//

import SwiftUI

struct SearchTagView: View {
    let tagList: [Tag]
    @Binding var selectedTag: Tag?
    @Environment(\.dismiss) private var dismiss
    
    @State private var searchText: String = ""
    
    var filteredTags: [Tag] {
        if searchText.isEmpty {
            return tagList
        } else {
            return tagList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        VStack {
            // Barra de búsqueda
            TextField("Buscar etiqueta", text: $searchText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            List {
                ForEach(filteredTags) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        if item.id == selectedTag?.id {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedTag = item
                        dismiss()
                    }
                }
            }
        }
        .navigationTitle("Seleccionar etiqueta")
    }
}
