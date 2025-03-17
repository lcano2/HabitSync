//
//  HabitsViewModel.swift
//  HabitSync2
//
//  Created by Luz Cano on 3/17/25.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class HabitsViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    private let db = Firestore.firestore()

    func fetchHabits() {
        db.collection("habits").addSnapshotListener { snapshot, error in
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
        do {
            let _ = try db.collection("habits").addDocument(from: habit)
        } catch {
            print("Error saving habit: \(error.localizedDescription)")
        }
    }
}




