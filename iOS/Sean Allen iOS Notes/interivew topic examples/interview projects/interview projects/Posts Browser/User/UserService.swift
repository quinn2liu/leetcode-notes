//
//  UserService.swift
//  interview projects
//
//  Created by Quinn Liu on 2/1/26.
//

import Foundation

protocol UserServicing {
    func fetchUsers() async throws -> [User]
}

class UserService: UserServicing {
    
    private let urlString: String = "https://jsonplaceholder.typicode.com/users"
    
    func fetchUsers() async throws -> [User] {
        
        guard let url: URL = URL(string: urlString) else { throw UserServiceError.invalidUrl }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw UserServiceError.invalidResponse }
        
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode([User].self, from: data)
        } catch {
            print(error)
            throw UserServiceError.decoderError
        }
    }
}

enum UserServiceError: String, Error {
    case invalidUrl, invalidRequest, invalidResponse, decoderError
}
