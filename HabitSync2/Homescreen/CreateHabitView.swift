//
//  CreateHabitView.swift
//  HabitSync2
//
//  Created by Luz Cano on 2/24/25.
//

import SwiftUI

struct CreateHabitView: View {
    @State private var habitName = ""
    @State private var selectedFrequency = "Daily"
    let frequencies = ["Daily", "Weekly", "Monthly"]
    
    @Binding var habits: [Habit]
    
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
                habits.append(newHabit)
                habitName = "" // Reset the habit name field
            }
            .padding()
            .disabled(habitName.isEmpty)
        }
        .navigationTitle("Create New Habit")
        
        NavigationStack {
            VStack {
                
                NavigationLink("Go to Account Page", destination:
                    ProfileView())
                    .padding()
                
                Link("Resources", destination: URL(string: "https://jamesclear.com/habits")!)
                    .padding()
            }
            .navigationTitle("Home")
        }
    }
}

