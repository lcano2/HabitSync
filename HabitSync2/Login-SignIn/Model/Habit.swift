//
//  Habit.swift
//  HabitSync2
//
//  Created by Luz Cano on 2/24/25.
//

import Foundation

struct Habit: Identifiable {
    var id = UUID()
    var name: String
    var frequency: String
    var createdDate: Date
}

