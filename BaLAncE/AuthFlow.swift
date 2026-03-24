//
//  AuthFlow.swift
//  BaLAncE
//
//  Created by applelab02 on 2/21/26.
//
//
//  AuthFlow.swift
//  BaLAncE
//

import SwiftUI
import Combine
import FirebaseAuth
import FirebaseFirestore

final class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
   
    func login(email: String, password: String) {
        errorMessage = nil
        isLoading = true

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    self.isAuthenticated = false
                    return
                }
                self.errorMessage = nil
                self.isAuthenticated = true
            }
        }
    }
    func signup(email: String, password: String, username: String) {
        errorMessage = nil
        isLoading = true

        // Basic field validation
        guard !email.isEmpty, !password.isEmpty, !username.isEmpty else {
            self.errorMessage = "Please fill all fields."
            self.isLoading = false
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self else { return }

            if let error = error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                    self.isAuthenticated = false
                }
                return
            }

            guard let user = result?.user else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Failed to create user."
                    self.isAuthenticated = false
                }
                return
            }

            // Prepare user profile data to store in Firestore
            let data: [String: Any] = [
                "uid": user.uid,
                "email": email,
                "username": username,
                "createdAt": FieldValue.serverTimestamp()
            ]

            let db = Firestore.firestore()
            db.collection("users").document(user.uid).setData(data) { [weak self] firestoreError in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let firestoreError = firestoreError {
                        self.errorMessage = firestoreError.localizedDescription
                        self.isAuthenticated = false
                        return
                    }
                    self.errorMessage = nil
                    self.isAuthenticated = true
                }
            }
        }
    }
    func logout() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}


struct AuthView: View {
    
    @ObservedObject var auth: AuthViewModel
    @State private var selection: Int = 0
    
    var body: some View {
        
        VStack(spacing: 24) {
            
            Spacer()
            
            Text("BaLAncE")
                .font(.largeTitle)
                .bold()
            
            Picker("Auth", selection: $selection) {
                Text("Log In").tag(0)
                Text("Sign Up").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            
            if selection == 0 {
                LoginView(auth: auth)
            } else {
                SignupView(auth: auth)
            }
            
            
            if let error = auth.errorMessage {
                Text(error)
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .padding(.horizontal)
            }
            
            if auth.isLoading {
                ProgressView()
                    .padding(.top, 8)
            }
            
            Spacer()
        }
        .padding()
    }
}



struct LoginView: View {
    
    @ObservedObject var auth: AuthViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        VStack(spacing: 12) {
            
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)
            
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            
            Button(action: {
                auth.login(email: email, password: password)
            }) {
                Text("Log In")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .disabled(auth.isLoading)
        }
        .padding(.horizontal)
    }
}



struct SignupView: View {
    
    @ObservedObject var auth: AuthViewModel
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        VStack(spacing: 12) {
            
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)
            
            
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
            
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            
            Button(action: {
                auth.signup(email: email, password: password, username: username)
            }) {
                Text("Create Account")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .disabled(auth.isLoading)
        }
        .padding(.horizontal)
    }
}



#Preview {
    AuthView(auth: AuthViewModel())
}
