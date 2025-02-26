//
//  HomeView.swift
//  HabitSync2
//
//  Created by Luz Cano on 2/24/25.
//

import SwiftUI

struct HomeView: View {
    @State private var isJournalPresented = false

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    isJournalPresented.toggle()
                }) {
                    Image("Little Plant")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 220)
                }
                .sheet(isPresented: $isJournalPresented) {
                    JournalView(isPresented: $isJournalPresented)
                }
                
                Text("Check-In")

                NavigationLink(destination: JournalHistoryView()) {
                    Text("View Journal Entries")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                
            }
        }
    }
}





struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



