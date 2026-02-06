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
class GHUserViewModel: ObservableObject {
    @Published var user: GHUser
    let userService: GHUserServicing
    @Published var profileImage: UIImage?
    @Published var isLoading: Bool
    
    init(user: GHUser, userService: GHUserServicing) {
        self.user = user
        self.userService = userService
        self.profileImage = nil
        self.isLoading = false
    }
    
    func getUserInfo() async {
        do {
            user = try await userService.getDetailedUser(username: user.username)
            isLoading = true
            profileImage = try await userService.getProfileImage(urlString: user.imageUrlString)
            isLoading = false
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
}
