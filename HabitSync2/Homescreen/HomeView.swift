//
//  HomeView.swift
//  HabitSync2
//
//  Created by Luz Cano on 2/24/25.
//

import SwiftUI

struct HomeView: View {
    @State private var isJournalPresented = false

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    isJournalPresented.toggle()
                }) {
                    Image("Little Plant")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 220)
                }
                .sheet(isPresented: $isJournalPresented) {
                    JournalView(isPresented: $isJournalPresented)
                }
                Text("Check-In")
            }
            .navigationTitle("Home")
        }
    }
}

struct JournalView: View {
    @Binding var isPresented: Bool
    @State private var journalEntry: String = ""
    @State private var subject: String = ""
    @State private var selectedDate: Date = Date()

    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()

                TextField("Subject", text: $subject)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Write your reflection...", text: $journalEntry)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Save Journal Entry") {
                    // Simulate saving the journal entry
                    print("Entry saved: \(journalEntry) on \(selectedDate)")
                    isPresented = false
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                Spacer()

                Button("Cancel") {
                    isPresented = false
                }
                .padding()
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
            .navigationTitle("Journal")
            .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

