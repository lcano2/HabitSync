//
//  HabitSync2App.swift
//  HabitSync2
//
//  Created by Luz Cano on 2/20/25.
//

import SwiftUI
import Firebase

@main
struct HabitSync2App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

