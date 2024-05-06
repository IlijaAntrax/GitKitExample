//
//  View+.swift
//  GitKit
//
//  Created by Ilija Antonijevic on 1.5.24..
//

import Foundation
import SwiftUI

extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    func navigateToNext<NewView: View>(view: NewView, when binding: Binding<Bool>) -> some View {
        ZStack {
            self
                .navigationBarTitle("")
                .navigationBarHidden(false)

            NavigationLink(
                destination: view
                    .navigationBarTitle("")
                    .navigationBarHidden(false),
                isActive: binding
            ) {
                EmptyView()
            }
        }
    }
}
