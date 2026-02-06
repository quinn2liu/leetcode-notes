//
//  GHUserListView.swift
//  interview projects
//
//  Created by Quinn Liu on 2/6/26.
//

import SwiftUI

struct GHUserListView: View {
    
    @ObservedObject var viewModel: GHUserListViewModel
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
            } else {
                UserList()
            }
        }
        .padding(.horizontal, 12)
        .navigationTitle("GitHub Users")
        .task {
            if viewModel.users.isEmpty {
                await viewModel.loadUsers()
            }
        }
    }
    
    @ViewBuilder
    private func UserList() -> some View {
        VStack {
            ForEach(viewModel.users) { user in
                NavigationLink(value: user) {
                    HStack {
                        Text("Username: \(user.username)")
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.gray)
                    .foregroundStyle(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
        }
    }
}

//#Preview {
//    GHUserListView()
//}
