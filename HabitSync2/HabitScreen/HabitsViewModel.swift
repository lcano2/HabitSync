//
//  HabitsViewModel.swift
//  HabitSync2
//
//  Created by Luz Cano on 3/17/25.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class HabitsViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    private let db = Firestore.firestore()

    func fetchHabits() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users").document(userId).collection("habits").addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error fetching habits: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.habits = documents.compactMap { doc -> Habit? in
                try? doc.data(as: Habit.self)
            }
        }
    }

    func addHabit(_ habit: Habit) {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        do {
            let _ = try db.collection("users").document(userId).collection("habits").addDocument(from: habit)
        } catch {
            print("Error saving habit: \(error.localizedDescription)")
        }
    }
}





