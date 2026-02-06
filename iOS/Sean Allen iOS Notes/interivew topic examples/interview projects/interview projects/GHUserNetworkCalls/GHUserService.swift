//
//  GHUserService.swift
//  interview projects
//
//  Created by Quinn Liu on 2/6/26.
//

import Foundation
import SwiftUI

protocol GHUserServicing {
    func getUserList() async throws -> [GHUser]
    
    func getDetailedUser(username: String) async throws -> GHUser
    
    func getProfileImage(urlString: String) async throws -> UIImage?
}

class GHUserService: GHUserServicing {
    
    // MARK: Get user list
    func getUserList() async throws -> [GHUser] {
        let urlString = "https://api.github.com/users"
        
        guard let url = URL(string: urlString) else { throw GHUserServiceError.invalidURL }
        
        // how to handle this
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw GHUserServiceError.invalidResponse }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([GHUser].self, from: data)
        } catch {
            print("decode error: \(error.localizedDescription)")
            throw GHUserServiceError.decodeError
        }
    }
    
    // MARK: get user details
    func getDetailedUser(username: String) async throws -> GHUser {
        let urlString = "https://api.github.com/users/\(username)"
        
        guard let url = URL(string: urlString) else { throw GHUserServiceError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw GHUserServiceError.invalidResponse }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(GHUser.self, from: data)
        } catch {
            print("decode error: \(error.localizedDescription)")
            throw GHUserServiceError.decodeError
        }
    }
    
    // MARK: getProfileImage
    @concurrent
    func getProfileImage(urlString: String) async throws -> UIImage? {
        guard let url = URL(string: urlString) else { throw GHUserServiceError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw GHUserServiceError.invalidResponse }
        
        return UIImage(data: data)
    }
}

enum GHUserServiceError: Error {
    case invalidURL, invalidResponse, decodeError, imageDecodeError
}
