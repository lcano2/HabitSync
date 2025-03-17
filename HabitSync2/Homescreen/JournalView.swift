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
    @State private var isDatePickerVisible: Bool = false

    let prompts = [
        "What are you grateful for today?",
        "Describe a moment that made you smile recently.",
        "What’s a challenge you’re currently facing?",
        "If you could give advice to your past self, what would it be?",
        "What are three things you love about yourself?",
        "Write about a time you stepped out of your comfort zone.",
        "What’s something new you learned this week?",
        "How do you want to feel by the end of today?",
        "Describe your dream life in five years.",
        "What’s one thing you wish more people knew about you?",
        "What’s a fear you’d like to overcome?",
        "Write about a small win you had recently.",
        "What’s a habit you want to build or break?",
        "If money wasn’t an issue, what would you do with your life?",
        "What’s something that always makes you feel better?",
        "Who inspires you the most and why?",
        "Describe your perfect day from start to finish.",
        "What’s something you’re currently working on improving?",
        "Write about a memory that brings you joy.",
        "What’s your biggest goal right now?",
        "What would you do if you weren’t afraid of failure?",
        "What’s one thing you want to let go of?",
        "Describe a moment when you felt truly at peace.",
        "If today was your last day, how would you spend it?",
        "What’s something you’ve been procrastinating on?",
        "Write about someone who has had a big impact on your life.",
        "What’s a book, movie, or song that changed your perspective?",
        "If you could master any skill instantly, what would it be?",
        "What does success mean to you?",
        "How do you want to be remembered?"
    ]

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
                        .onChange(of: selectedDate) { newValue in
                            isDatePickerVisible = false
                        }
                }

                Text(subject)
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)


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
            .onAppear {
                subject = prompts.randomElement() ?? "What’s on your mind today?"
            }
        }
    }

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
                
                DispatchQueue.main.async {
                    isPresented = false
                }
            }
        }
    }
}

#Preview {
    JournalView(isPresented: .constant(true))
}


