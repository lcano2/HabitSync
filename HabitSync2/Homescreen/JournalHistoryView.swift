//
//  JournalHistoryView.swift
//  HabitSync2
//
//  Created by Luz Cano on 2/25/25.
//

import SwiftUI
import Firebase

struct JournalHistoryView: View {
    @State private var journalEntries: [JournalEntry] = []

    var body: some View {
        NavigationView {
            List(journalEntries, id: \.uniqueID) { entry in
                NavigationLink(destination: JournalDetailView(entry: entry)) {
                    VStack(alignment: .leading) {
                        Text(entry.subject)
                            .font(.headline)
                        Text(entry.date.dateValue(), style: .date)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Journal Entries")
            .onAppear {
                fetchJournalEntries()
            }
        }
    }

    func fetchJournalEntries() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()

        db.collection("users").document(userID).collection("journalEntries")
            .order(by: "date", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching journal entries: \(error.localizedDescription)")
                    return
                }

                if let documents = snapshot?.documents {
                    let newEntries = documents.compactMap { doc -> JournalEntry? in
                        try? doc.data(as: JournalEntry.self)
                    }

                    DispatchQueue.main.async {
                        self.journalEntries = newEntries
                    }
                }
            }
    }
}


struct JournalHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        JournalHistoryView()
    }
}
