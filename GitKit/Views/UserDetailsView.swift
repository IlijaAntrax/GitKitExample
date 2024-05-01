//
//  UserDetailsView.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation

import SwiftUI

struct UserDetailsView: View {
        
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var reposViewModel: ReposViewModel
    @EnvironmentObject var commitsViewModel: CommitsViewModel
    
    var body: some View {
        VStack {
            Image("GitIcon")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.33)
                .foregroundStyle(.tint)
            Button(action: test,
                   label: { Text("Test")
                            .padding()
                            .frame(maxWidth: .infinity) })
                .foregroundColor(.white)
                .background(Color.primaryColor)
                .cornerRadius(10.0)
                .padding()
        }
        .padding()
    }
    
    func test() {
        reposViewModel.getRepositories { _ in }
        commitsViewModel.getCommits(repo: "Memories") { _ in }
    }
}

#Preview {
    UserDetailsView()
        .environmentObject(AppContainer.provideAuthViewModel())
        .environmentObject(AppContainer.provideReposViewModel())
        .environmentObject(AppContainer.provideCommitsViewModel())
}
