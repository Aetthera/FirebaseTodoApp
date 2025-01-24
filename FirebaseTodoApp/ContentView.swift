//
//  ContentView.swift
//  FirebaseTodoApp
//
//  Created by Alena Belova  on 2025-01-15.
//

import SwiftUI

struct ContentView: View {
    @State private var todos: [Todo] = []
    @State private var isShowingAddTodoView = false
    private let firestoreService = FirestoreService()

    var body: some View {
        NavigationView {
            List(todos) { todo in
                HStack {
                    Text(todo.title)
                    Spacer()
                    Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                        .onTapGesture {
                            var updatedTodo = todo
                            updatedTodo.isCompleted.toggle()
                            firestoreService.updateTodo(updatedTodo) { _ in
                                loadTodos()
                            }
                        }
                }
            }
            .navigationTitle("Todos")
            .navigationBarItems(trailing: Button("Add") {
                isShowingAddTodoView = true
            })
            .sheet(isPresented: $isShowingAddTodoView) {
                AddTodoView { newTodoTitle in
                    let newTodo = Todo(
                        id: UUID(),
                        title: newTodoTitle,
                        isCompleted: false
                    )
                    firestoreService.addTodo(newTodo) { _ in
                        loadTodos()
                    }
                }
            }
            .onAppear {
                loadTodos()
            }
        }
    }

    private func loadTodos() {
        firestoreService.fetchTodos { fetchedTodos, _ in
            if let fetchedTodos = fetchedTodos {
                todos = fetchedTodos
            }
        }
    }
}

#Preview {
    ContentView()
}
