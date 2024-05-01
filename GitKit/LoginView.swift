//
//  LoginView.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
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
    }
    
    func login() {
        authViewModel.login()
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
