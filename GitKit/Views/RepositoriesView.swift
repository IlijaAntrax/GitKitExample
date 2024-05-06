//
//  RepositoriesView.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 6.5.24..
//

import Foundation
import SwiftUI

struct RepositoriesView: View {
        
    @StateObject var reposViewModel: ReposViewModel = AppContainer.provideReposViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(reposViewModel.repositories, id: \.id) { repository in
                    VStack(alignment: .leading) {
                        HStack(content: {
                            Text(repository.name ?? "")
                        })
                        HStack(content: {
                            Text("Language: ")
                            Text(repository.language ?? "")
                        })
                        HStack(content: {
                            Text("Branch: ")
                            Text(repository.defaultBranch ?? "")
                        })
                        NavigationLink(
                            "See Commits", destination: CommitsView(commitsViewModel: AppContainer.provideCommitsViewModel(repo: repository.name ?? ""))
                        )
                    }.padding(.bottom)
                }
            }
        }
        .padding()
    }
}

#Preview {
    RepositoriesView()
}
