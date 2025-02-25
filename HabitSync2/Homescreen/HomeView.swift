//
//  HomeView.swift
//  HabitSync2
//
//  Created by Luz Cano on 2/24/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Home Page")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                NavigationLink("Go to Account Page", destination:
                    ProfileView())
                    .padding()
                Spacer()
                
                Link("Resources", destination: URL(string: "https://jamesclear.com/habits")!)
                    .padding()
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
