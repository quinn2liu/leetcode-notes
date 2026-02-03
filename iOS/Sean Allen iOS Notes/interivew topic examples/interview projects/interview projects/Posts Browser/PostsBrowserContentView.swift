//
//  PostsBrowserContentView.swift
//  interview projects
//
//  Created by Quinn Liu on 2/1/26.
//

import SwiftUI

struct PostsBrowserContentView: View {
    
    @State var path = NavigationPath()
    @State var userListViewModel = UserListViewModel(userService: UserService())
    let postService: PostServicing = PostService()
    
    var body: some View {
        NavigationStack(path: $path) {
            UserListView(viewModel: $userListViewModel)
                .navigationDestination(for: User.self) { user in
                        UserDetailView(user: user, postService: postService)
                }
        }
    }
}

// Order of operations for the posts browser

// 1. create the model for posts and users

// /posts     100 posts
// /comments  500 comments
// /albums    100 albums
// /photos    5000 photos
// /todos    200 todos
// /users    10 users

// sample url: https://jsonplaceholder.typicode.com/todos

// 2. create dummy UI for the functionality we are trying to achieve
// 3. create networking code
// 4. connect the networking code
// 5. write tests

#Preview {
    PostsBrowserContentView()
}
