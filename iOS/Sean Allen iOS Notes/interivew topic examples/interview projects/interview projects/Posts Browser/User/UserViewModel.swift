//
//  UserViewModel.swift
//  interview projects
//
//  Created by Quinn Liu on 2/1/26.
//

import Foundation

@Observable
class UserViewModel {
    
    let user: User
    let postService: PostServicing
    var posts: [Post]
    
    init(user: User, postService: PostServicing) {
        self.user = user
        self.postService = postService
        self.posts = []
    }
    
    func fetchPosts() async {
        do {
            posts = try await  postService.getPostsForUser(userId: user.id)
        } catch {
            print("error")
        }
    }
}
