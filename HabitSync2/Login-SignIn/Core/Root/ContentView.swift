//
//  ContentView.swift
//  HabitSync2
//
//  Created by Luz Cano on 2/20/25.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginView()
            } else {
                NavigationSplitView {
                    CreateHabitView(habits: .constant([]))
                    //HomeView()
                } detail: {
                    ProfileView()
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

