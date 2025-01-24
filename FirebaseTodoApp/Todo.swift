//
//  Todo.swift
//  FirebaseTodoApp
//
//  Created by Alena Belova  on 2025-01-15.
//

import Foundation
import FirebaseFirestore


struct Todo: Identifiable, Codable {
    var id: UUID
    var title: String
    var isCompleted: Bool
}
