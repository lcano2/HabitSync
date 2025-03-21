//
//  LoginView.swift
//  HabitSync2
//
//  Created by Luz Cano on 2/20/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.85, green: 0.91, blue: 0.80) 
                    .ignoresSafeArea()
                
                VStack {
                    // Image
                    Image("Little Plant")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 120)
                        .padding(.vertical, 32)
                    
                    // Form fields
                    VStack(spacing: 24) {
                        InputView(text: $email,
                                  title: "Email Address",
                                  placeholder: "name@example.com")
                        .autocapitalization(.none)
                        
                        InputView(text: $password,
                                  title: "Password",
                                  placeholder: "Enter your password",
                                  isSecureField: true)
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    // Sign-in button
                    Button {
                        Task {
                            print("DEBUG: Sign In button tapped") // Debug print
                            do {
                                try await viewModel.signIn(withEmail: email, password: password)
                            } catch {
                                print("DEBUG: Sign In error - \(error.localizedDescription)")
                            }
                        }
                    } label: {
                        HStack {
                            Text("SIGN IN")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    }
                    .background(Color(.systemBlue))
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    .cornerRadius(10)
                    .padding(.top, 24)

                    Spacer()
                    
                    // Sign-up button
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack(spacing: 2) {
                            Text("Don't have an account?")
                            Text("Sign up")
                                .fontWeight(.bold)
                        }
                        .font(.system(size: 14))
                    }
                }
            }
        }
    }
}


extension LoginView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}


struct LoginView_Previews: PreviewProvider{
    static var previews: some View{
        LoginView()
    }
}
