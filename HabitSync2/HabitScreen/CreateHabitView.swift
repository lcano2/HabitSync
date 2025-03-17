//
//  CreateHabitView.swift
//  HabitSync2
//
//  Created by Luz Cano on 2/24/25.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CreateHabitView: View {
    @State private var habitName = ""
    @State private var selectedFrequency = "Daily"
    let frequencies = ["Daily", "Weekly", "Monthly"]
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: HabitsViewModel  // Use the same ViewModel

    var body: some View {
        VStack {
            TextField("Enter habit name", text: $habitName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Picker("Frequency", selection: $selectedFrequency) {
                ForEach(frequencies, id: \.self) { frequency in
                    Text(frequency)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Button("Add Habit") {
                let newHabit = Habit(name: habitName, frequency: selectedFrequency, createdDate: Date())
                viewModel.addHabit(newHabit)  // Call ViewModel function to add habit
                habitName = ""
                dismiss()  // Close the view after adding the habit
            }
            .padding()
            .disabled(habitName.isEmpty)
        }
        .navigationTitle("Create New Habit")
    }
}

