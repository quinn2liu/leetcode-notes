//
//  PostService.swift
//  interview projects
//
//  Created by Quinn Liu on 2/2/26.
//

import Foundation

protocol PostServicing {
    func getPostsForUser(userId: String) async throws -> [Post]
}

class PostService: PostServicing {
    
    let urlString: String =  "https://jsonplaceholder.typicode.com/posts"

    
    func getPostsForUser(userId: String) async throws -> [Post] {
        guard let userIdNum = Int(userId) else { throw PostServiceError.invalidUserId }
        
        guard let url: URL = URL(string: urlString) else { throw PostServiceError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw PostServiceError.invalidResponse }
        
        var posts: [Post] = []
        do {
            let decoder = JSONDecoder()
            posts = try decoder.decode([Post].self, from: data)
        } catch {
            throw PostServiceError.decoderError
        }
        
        let userPosts = posts.filter { $0.userId == userIdNum }
        
        return userPosts
    }
}

enum PostServiceError: String, Error {
    case invalidUrl, invalidUserId, invalidURL, invalidResponse, decoderError
}
