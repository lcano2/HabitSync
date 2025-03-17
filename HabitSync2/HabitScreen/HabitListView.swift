//
//  HabitListView.swift
//  HabitSync2
//
//  Created by Luz Cano on 3/17/25.
//

import SwiftUI

struct HabitListView: View {
    @StateObject private var viewModel = HabitsViewModel()
    @State private var isShowingCreateHabitView = false  // Controls navigation to CreateHabitView

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.habits) { habit in
                    VStack(alignment: .leading) {
                        Text(habit.name)
                            .font(.headline)
                        Text("Frequency: \(habit.frequency)")
                            .font(.subheadline)
                        Text("Created on: \(habit.createdDate.formatted(date: .abbreviated, time: .omitted))")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                .navigationTitle("Habits")
                .onAppear {
                    viewModel.fetchHabits()  // Fetch habits from Firestore
                }

                Button(action: {
                    isShowingCreateHabitView = true
                }) {
                    Text("Add New Habit")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .sheet(isPresented: $isShowingCreateHabitView) {
                    CreateHabitView(viewModel: viewModel)
                }
            }
        }
    }
}



