//
//  UserListViewModel.swift
//  interview projects
//
//  Created by Quinn Liu on 2/1/26.
//

import Foundation



@Observable
class UserListViewModel {
    var users: [User] = []
    
    let userService: UserServicing
    
    init(userService: UserServicing) {
        self.userService = userService
    }
    
    func loadUsers() async {
        do {
            users = try await userService.fetchUsers()
        } catch UserServiceError.decoderError {
            print(UserServiceError.decoderError.rawValue)
        } catch UserServiceError.invalidRequest {
            print(UserServiceError.invalidRequest.rawValue)
        } catch UserServiceError.invalidUrl {
            print(UserServiceError.invalidUrl.rawValue)
        } catch UserServiceError.invalidResponse {
            print(UserServiceError.invalidResponse.rawValue)
        } catch {
            print("unexpected error")
        }
    }
}
