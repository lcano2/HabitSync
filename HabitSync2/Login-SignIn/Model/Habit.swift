//
//  Habit.swift
//  HabitSync2
//
//  Created by Luz Cano on 2/24/25.
//

import Foundation
import FirebaseFirestoreSwift

struct Habit: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var frequency: String
    var createdDate: Date

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case frequency
        case createdDate
    }
}



