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
        ZStack {
            Color(red: 0.85, green: 0.91, blue: 0.80)
                .ignoresSafeArea()

            VStack {
                TextField("Enter habit name", text: $habitName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 24)
                
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
                    habitName = ""
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.horizontal, 24)
                .disabled(habitName.isEmpty)
                .opacity(habitName.isEmpty ? 0.5 : 1.0)

                Spacer()
                

            }
            .navigationTitle("Create New Habit")
        }
    }
}


