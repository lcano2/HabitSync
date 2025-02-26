//
//  ContentView.swift
//  HabitSync2
//
//  Created by Luz Cano on 2/20/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Group {
                if viewModel.userSession == nil {
                    LoginView()
                } else {
                    TabView {
                        NavigationView {
                            HomeView()
                                .navigationTitle("Home")
                        }
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                        
                        NavigationView {
                            CreateHabitView(habits: .constant([]))
                                .navigationTitle("Create Habit")
                        }
                        .tabItem {
                            Label("Habits", systemImage: "list.bullet")
                        }
                        
                        NavigationView {
                            ProfileView()
                                .navigationTitle("Profile")
                        }
                        .tabItem {
                            Label("Profile", systemImage: "person.fill")
                        }
                    }
                }
            }
        }
        .onAppear {
            print("DEBUG: ContentView appeared. Current user session: \(String(describing: viewModel.userSession))")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


