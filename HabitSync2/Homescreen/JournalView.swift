//
//  JournalView.swift
//  HabitSync2
//
//  Created by Luz Cano on 2/25/25.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct JournalView: View {
    @Binding var isPresented: Bool
    @State private var journalEntry: String = ""
    @State private var subject: String = ""
    @State private var selectedDate: Date = Date()
    @State private var journalEntries: [JournalEntry] = []
    @State private var isDatePickerVisible: Bool = false  // Initially hidden

    func saveJournalEntry() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No user logged in")
            return
        }

        let db = Firestore.firestore()
        let journalEntryData: [String: Any] = [
            "subject": subject,
            "entry": journalEntry,
            "date": Timestamp(date: selectedDate)
        ]

        db.collection("users").document(userID).collection("journalEntries").addDocument(data: journalEntryData) { error in
            if let error = error {
                print("Error saving journal entry: \(error.localizedDescription)")
            } else {
                print("Journal entry saved successfully!")
                fetchJournalEntries()
                DispatchQueue.main.async {
                    isPresented = false
                }
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

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Button(action: { isDatePickerVisible.toggle() }) {
                    HStack {
                        Text("Select Date: \(selectedDate.formatted(date: .abbreviated, time: .omitted))")
                        Spacer()
                        Image(systemName: isDatePickerVisible ? "chevron.up" : "chevron.down")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                }

                if isDatePickerVisible {
                    DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .onChange(of: selectedDate) { _ in
                            isDatePickerVisible = false  // Hide after selection
                        }
                }

                TextField("Journal Prompt", text: $subject)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                TextEditor(text: $journalEntry)
                    .frame(height: 120)
                    .padding(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    .padding(.horizontal)

                Button("Save Journal Entry") {
                    saveJournalEntry()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.horizontal)

                Button("Cancel") {
                    isPresented = false
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.red)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)

            }
            .navigationTitle("Journal")
            .padding(.top)
            .onAppear { fetchJournalEntries() }
        }
    }
}

#Preview {
    JournalView(isPresented: .constant(true))
}


