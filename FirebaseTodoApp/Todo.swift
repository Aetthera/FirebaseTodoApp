//
//  Todo.swift
//  FirebaseTodoApp
//
//  Created by Alena Belova  on 2025-01-15.
//

import Foundation
import FirebaseFirestore


struct Todo: Identifiable, Codable{
    @DocumentID var id: String? // Firestore will create this, so we use ?
    var title: String
    var isDone: Bool

}
