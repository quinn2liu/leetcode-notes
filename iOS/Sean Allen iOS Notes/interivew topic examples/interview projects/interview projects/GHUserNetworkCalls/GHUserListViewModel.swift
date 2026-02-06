//
//  GHUserViewModel.swift
//  interview projects
//
//  Created by Quinn Liu on 2/6/26.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
class GHUserListViewModel: ObservableObject {
    let userService: GHUserServicing
    @Published var users: [GHUser]
    @Published var isLoading: Bool
    
    init(userService: GHUserServicing, users: [GHUser] = []) {
        self.users = []
        self.userService = userService
        self.isLoading = false
    }
    
    func loadUsers() async {
        do {
            isLoading = true
            users = try await userService.getUserList()
            isLoading = false
        } catch GHUserServiceError.decodeError {
            print("decodeError")
        } catch GHUserServiceError.invalidURL {
            print("invalidURL")
        } catch GHUserServiceError.invalidResponse {
            print("invalidResponse")
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
}
