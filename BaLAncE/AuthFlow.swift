//
//  AuthFlow.swift
//  BaLAncE
//
//  Created by applelab02 on 2/21/26.
//

import SwiftUI
import Combine

final class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var users: [String: String] = [:] // email -> password

    func login(email: String, password: String) {
        errorMessage = nil
        isLoading = true
        // Simulate async auth; replace with real backend later
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            guard let self else { return }
            self.isLoading = false
            if email.isEmpty || password.isEmpty {
                self.errorMessage = "Please enter email and password."
                return
            }

            guard let savedPassword = self.users[email] else {
                self.errorMessage = "No account found for this email. Please sign up."
                return
            }

            guard password == savedPassword else {
                self.errorMessage = "Password is incorrect."
                return
            }

            self.errorMessage = nil
            self.isAuthenticated = true
        }
    }

    func signup(email: String, password: String, username: String) {
        errorMessage = nil
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            guard let self else { return }
            self.isLoading = false
            if email.isEmpty || password.isEmpty || username.isEmpty {
                self.errorMessage = "Please fill all fields."
                return
            }

            // Add or update the user in-memory
            self.users[email] = password

            self.errorMessage = nil
            self.isAuthenticated = false
        }
    }

    func logout() {
        isAuthenticated = false
    }
}

struct AuthView: View {
    @ObservedObject var auth: AuthViewModel
    @State private var selection: Int = 0

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Text("BaLAncE")
                .font(.largeTitle).bold()

            Picker("Auth", selection: $selection) {
                Text("Log In").tag(0)
                Text("Sign Up").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            if selection == 0 {
                LoginView(auth: auth)
                
            }
            else{
                SignupView(auth: auth)
            }

            if let error = auth.errorMessage {
                Text(error)
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .padding(.horizontal)
            }

            if auth.isLoading {
                ProgressView().padding(.top, 8)
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
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            Button(action: { auth.login(email: email, password: password) }) {
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
                .textFieldStyle(.roundedBorder)
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            Button(action: { auth.signup(email: email, password: password, username: username) }) {
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
