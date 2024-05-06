//
//  LoginView.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import SwiftUI

struct LoginView: View {
    
    @State private var loginFailed = false
    @State private var goToUserDetails = false
    
    @StateObject var authViewModel: AuthViewModel = AppContainer.provideAuthViewModel()
    
    var body: some View {
        if authViewModel.isLoggedIn {
            UserDetailsView()
        } else {
            VStack {
                Image("GitIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.33)
                    .foregroundStyle(.tint)
                Text("Please enter your GitHub username")
                    .font(.headline)
                    .padding(.bottom)
                TextField("Username", text: $authViewModel.username)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10.0)
                        .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
                    .padding(.horizontal)
                    .onSubmit {
                        login()
                    }
                Button(action: login,
                       label: { Text("Login")
                        .padding()
                    .frame(maxWidth: .infinity) })
                .foregroundColor(.white)
                .background(Color.primaryColor)
                .cornerRadius(10.0)
                .padding()
                .disabled(authViewModel.username.isEmpty)
            }
            .padding()
            .alert("Error", isPresented: $loginFailed) {
                Button("OK") {
                    authViewModel.clearError()
                }
            } message: {
                Text(authViewModel.loginError)
            }
            .navigate(to: UserDetailsView(), when: $goToUserDetails)
        }
    }
    
    func login() {
        authViewModel.login { success in
            if success {
                goToUserDetails = true
            } else {
                loginFailed = true
            }
        }
    }
}

#Preview {
    LoginView()
}
