//
//  JournalDetailView.swift
//  HabitSync2
//
//  Created by Luz Cano on 2/25/25.
//

import SwiftUI

struct JournalDetailView: View {
    var entry: JournalEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(entry.subject)
                .font(.title)
                .bold()

            Text(entry.date.dateValue(), style: .date)
                .font(.subheadline)
                .foregroundColor(.gray)

            Divider()

            Text(entry.entry)
                .font(.body)

            Spacer()
        }
        .padding()
        .navigationTitle("Entry Details")
    }
}
