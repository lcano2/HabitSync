//
//  JournalEntry.swift
//  HabitSync2
//
//  Created by Luz Cano on 2/25/25.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct JournalEntry: Identifiable, Decodable {
    @DocumentID var id: String?
    var subject: String
    var entry: String
    var date: Timestamp  // Firestore expects Timestamp here

    var uniqueID: String {
        // Return either the id or a generated UUID if id is nil
        id ?? UUID().uuidString
    }

    enum CodingKeys: String, CodingKey {
        case id
        case subject
        case entry
        case date
    }

    // Custom initializer to convert Date to Timestamp when saving
    init(id: String? = nil, subject: String, entry: String, date: Date) {
        self.id = id
        self.subject = subject
        self.entry = entry
        self.date = Timestamp(date: date)  // Convert Date to Timestamp here
    }

    // Decoder method to convert Firestore Timestamp to Date
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        subject = try container.decode(String.self, forKey: .subject)
        entry = try container.decode(String.self, forKey: .entry)

        // Decode Timestamp and convert it to Date
        let timestamp = try container.decode(Timestamp.self, forKey: .date)
        date = timestamp  // Keep it as a Timestamp
    }

    // Encoder method to save to Firestore
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encode(subject, forKey: .subject)
        try container.encode(entry, forKey: .entry)
        try container.encode(date, forKey: .date)  // No need to convert back; Firestore expects Timestamp
    }
}

