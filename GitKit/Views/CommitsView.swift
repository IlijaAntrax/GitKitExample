//
//  CommitsView.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 6.5.24..
//

import Foundation
import SwiftUI

struct CommitsView: View {
    
    var repo: String
    
    @StateObject var commitsViewModel: CommitsViewModel = AppContainer.provideCommitsViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(commitsViewModel.commits, id: \.date) { commit in
                    VStack(alignment: .leading) {
                        Text(commit.authorName ?? "")
                            .font(.headline)
                        Text(commit.authorEmail ?? "")
                            .font(.headline)
                            .padding(.init(top: 0, leading: 0, bottom: 5, trailing: 0))
                        Text(commit.message ?? "")
                            .padding(.init(top: 0, leading: 0, bottom: 5, trailing: 0))
                        Text(commit.date?.toDate() ?? "")
                    }.padding(.bottom)
                }
            }
        }
        .padding()
        .onAppear(perform: {
            commitsViewModel.getCommits(repoName: repo)
        })
    }
}

#Preview {
    CommitsView(repo: "Test")
}
