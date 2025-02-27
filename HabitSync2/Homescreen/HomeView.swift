//
//  HomeView.swift
//  HabitSync2
//
//  Created by Luz Cano on 2/24/25.
//

import SwiftUI

struct HomeView: View {
    @State private var isJournalPresented = false
    
    // Format the date
    private var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: Date())
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Background color
                Color(red: 0.85, green: 0.91, blue: 0.80)
                    .ignoresSafeArea()
                
                VStack {
                    // Display the current date
                    Text(currentDate)
                        .font(.headline)
                        .padding(.bottom, 8)

                    Button(action: {
                        isJournalPresented.toggle()
                    }) {
                        Image("Little_Plant_2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 400, height: 420)
                    }
                    .sheet(isPresented: $isJournalPresented) {
                        JournalView(isPresented: $isJournalPresented)
                    }
                    
                    Text("Check-In")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 8)

                    NavigationLink(destination: JournalHistoryView()) {
                        Text("View Journal Entries")
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.horizontal, 24)
                    }
                    .padding(.top, 12)
                    
                    Link("Resources", destination: URL(string: "https://jamesclear.com/habits")!)
                        .padding()
                }
            }
        }
    }
}






struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



