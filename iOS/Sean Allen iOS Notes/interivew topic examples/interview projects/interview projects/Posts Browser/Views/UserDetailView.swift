//
//  UserDetailView.swift
//  interview projects
//
//  Created by Quinn Liu on 2/2/26.
//

import SwiftUI

struct UserDetailView: View {
    
    @State var viewModel: UserViewModel
    
    init(user: User, postService: PostServicing) {
        self.viewModel = UserViewModel(user: user, postService: postService)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Username: \(viewModel.user.username)")
                
                Text("Email: \(viewModel.user.email)")
                
                Text("Phone: \(viewModel.user.phone)")
                
                UserPosts()
            }
            .navigationTitle(viewModel.user.name)
            .task {
                await viewModel.fetchPosts()
            }
        }
    }
    
    @ViewBuilder
    private func UserPosts() -> some View {
        LazyVStack {
            ForEach(viewModel.posts) { post in
                VStack {
                    Text(post.title)
                    
                    Text(post.body)
                }
                .padding()
                .foregroundStyle(Color.white)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}

//#Preview {
//    UserDetailView()
//}
