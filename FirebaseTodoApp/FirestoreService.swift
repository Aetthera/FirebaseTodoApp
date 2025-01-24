//
//  FirestoreService.swift
//  FirebaseTodoApp
//
//  Created by Alena Belova  on 2025-01-23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreService {
    private let db = Firestore.firestore()

    func addTodo(_ todo: Todo, completion: @escaping (Error?) -> Void) {
        do {
            try db.collection("todos").document(todo.id.uuidString).setData(from: todo, completion: completion)
        } catch let error {
            completion(error)
        }
    }

    func fetchTodos(completion: @escaping ([Todo]?, Error?) -> Void) {
        db.collection("todos").getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
            } else {
                let todos = snapshot?.documents.compactMap { document in
                    try? document.data(as: Todo.self)
                }
                completion(todos, nil)
            }
        }
    }

    func updateTodo(_ todo: Todo, completion: @escaping (Error?) -> Void) {
        do {
            try db.collection("todos").document(todo.id.uuidString).setData(from: todo, completion: completion)
        } catch let error {
            completion(error)
        }
    }

    func deleteTodo(_ id: String, completion: @escaping (Error?) -> Void) {
        db.collection("todos").document(id).delete(completion: completion)
    }
}
