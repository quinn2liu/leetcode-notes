//
//  UserListView.swift
//  interview projects
//
//  Created by Quinn Liu on 2/1/26.
//

import SwiftUI

struct UserListView: View {
    @Binding var viewModel: UserListViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.users) { user in
                    NavigationLink(value: user) {
                        UserListItem(user)
                    }
                }
            }
        }
        .navigationTitle("Users List")
        .task {
            await viewModel.loadUsers()
        }
    }
    
    @ViewBuilder
    private func UserListItem(_ user: User) -> some View {
        HStack(spacing: 12) {
            Text(user.username)
            Text(user.name)
            Text(user.phone)
        }
        .foregroundStyle(Color.white)
        .padding()
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

//#Preview {
//    UserListView()
//}
