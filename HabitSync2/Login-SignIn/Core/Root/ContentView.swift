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
                            HabitListView()  
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
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}



