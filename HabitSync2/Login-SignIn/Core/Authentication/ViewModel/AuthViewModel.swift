//
//  AuthViewModel.swift
//  HabitSync2
//
//  Created by Luz Cano on 2/20/25.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

protocol AuthenticationFormProtocol{
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        if let savedUser = UserDefaults.standard.string(forKey: "userSession") {
            self.userSession = Auth.auth().currentUser
        }
        print("DEBUG: User session initialized: \(String(describing: self.userSession))")
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            DispatchQueue.main.async {
                self.userSession = result.user
            }
            await fetchUser()
        } catch {
            print("DEBUG: Failed to login with error \(error.localizedDescription)")
        }
    }
    
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut() //signs out user on backend
            self.userSession = nil //wipes out user session and takes us back to login screen
            self.currentUser = nil //wipes out current user data model
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() async {
        guard let user = Auth.auth().currentUser else {
            print("DEBUG: No user logged in")
            return
        }
        
        // Step 1: Delete user data from Firestore (if any)
        do {
            try await Firestore.firestore().collection("users").document(user.uid).delete()
            print("DEBUG: User data deleted from Firestore.")
        } catch {
            print("DEBUG: Failed to delete user data from Firestore with error \(error.localizedDescription)")
        }
        
        // Step 2: Delete the user from Firebase Authentication
        do {
            try await user.delete()
            print("DEBUG: User account deleted from Firebase Authentication.")
            
            // Step 3: Update the user session to nil (log out the user)
            DispatchQueue.main.async {
                self.userSession = nil
            }
            
        } catch {
            print("DEBUG: Failed to delete user account with error \(error.localizedDescription)")
        }
    }


    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("DEBUG: User UID not found")
            return
        }
        do {
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            if let data = snapshot.data() {
                self.currentUser = try? snapshot.data(as: User.self)
                print("DEBUG: User fetched successfully: \(String(describing: self.currentUser))")
            } else {
                print("DEBUG: No user data found for uid: \(uid)")
            }
        } catch {
            print("DEBUG: Error fetching user data: \(error.localizedDescription)")
        }
    }
}

