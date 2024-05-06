//
//  UserDetailsView.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation
import SwiftUI

struct UserDetailsView: View {
        
    @StateObject var userViewModel: UserViewModel = AppContainer.provideUserViewModel()
    
    @State private var goToRepositories = false
    
    var body: some View {
        if userViewModel.isLoggedIn {
            NavigationView {
                ZStack {
                    VStack {
                        AsyncImage(url: URL(string: userViewModel.avatarUrl)) { image in
                            image.image?.resizable()
                        }
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 0.33)
                            .foregroundStyle(.tint)
                            .padding(.bottom)
                        HStack(content: {
                            Text("Username: ")
                                .frame(width: UIScreen.main.bounds.width * 0.25, alignment: .leading)
                            Text(userViewModel.username)
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }).padding(.horizontal)
                        HStack(content: {
                            Text("Company: ")
                                .frame(width: UIScreen.main.bounds.width * 0.25, alignment: .leading)
                            Text(userViewModel.company)
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }).padding(.horizontal)
                        HStack(content: {
                            Text("Fullname: ")
                                .frame(width: UIScreen.main.bounds.width * 0.25, alignment: .leading)
                            Text(userViewModel.fullName)
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }).padding(.horizontal)
                        HStack(content: {
                            Text("Email: ")
                            Text(userViewModel.email)
                                .frame(maxWidth: .infinity)
                        }).padding(.horizontal)
                        Button(action: seeRepositories,
                               label: { Text("See Repositories")
                                .padding(.horizontal)
                                        .frame(maxWidth: .infinity) })
                            .foregroundColor(.white)
                            .background(Color.primaryColor)
                            .cornerRadius(10.0)
                            .padding()
                        Button(action: logout,
                               label: { Text("Logout")
                                .padding()
                            .frame(maxWidth: .infinity) })
                        .foregroundColor(.white)
                        .background(Color.primaryColor)
                        .cornerRadius(10.0)
                        .padding()
                    }
                    .padding()
                    .navigateToNext(view: RepositoriesView(), when: $goToRepositories)
                }
            }
            .navigationViewStyle(.stack)
        } else {
            LoginView()
        }
    }
    
    func seeRepositories() {
        goToRepositories = true
    }
    
    func logout() {
        userViewModel.logout()
    }
}

#Preview {
    UserDetailsView()
}
