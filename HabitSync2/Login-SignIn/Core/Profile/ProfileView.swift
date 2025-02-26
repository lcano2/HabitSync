//
//  ProfileView.swift
//  HabitSync2
//
//  Created by Luz Cano on 2/20/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.85, green: 0.91, blue: 0.80)
                    .ignoresSafeArea()
                
                if let user = viewModel.currentUser {
                    List {
                        Section {
                            HStack {
                                Text(user.initials)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(width: 72, height: 72)
                                    .background(Color(.systemGray3))
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(user.fullname)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .padding(.top, 4)
                                    
                                    Text(user.email)
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        
                        Section("General") {
                            HStack {
                                SettingsRowView(imageName: "gear",
                                                 title: "Version",
                                                 tintColor: Color(.systemGray))
                                
                                Spacer()
                                Text("1.0.0")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Section("Account") {
                            Button {
                                viewModel.signOut()
                            } label: {
                                SettingsRowView(imageName: "arrow.left.circle.fill",
                                                 title: "Sign out",
                                                 tintColor: .red)
                            }
                            
                            Button {
                                Task {
                                    print("Delete account...")
                                    await viewModel.deleteAccount()
                                }
                            } label: {
                                SettingsRowView(imageName: "xmark.circle.fill",
                                                 title: "Delete Account",
                                                 tintColor: .red)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden) // Hide default background of List
                    .background(Color(red: 0.85, green: 0.91, blue: 0.80)) // Match background
                    .navigationTitle("Profile")
                } else {
                    Text("Loading user data...")
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}


struct ProfileView_Previews: PreviewProvider{
    static var previews: some View{
        ProfileView()
    }
}
