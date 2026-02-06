//
//  GHUserView.swift
//  interview projects
//
//  Created by Quinn Liu on 2/6/26.
//

import SwiftUI

struct GHUserDetailView: View {

    @StateObject var viewModel: GHUserViewModel
    
    init(user: GHUser, userService: GHUserServicing) {
        _viewModel = StateObject(wrappedValue: GHUserViewModel(user: user, userService: userService))
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            if viewModel.isLoading {
                ProgressView()
                    .frame(width: 100, height: 100)
            } else {
                ProfileImage()
            }
            
            UserInfo()
        }
        .padding(.horizontal, 12)
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationTitle(viewModel.user.username)
        .task {
            if viewModel.profileImage == nil {
                await viewModel.getUserInfo()
            } else {
                print("viewModel.profileImage is not nil")
            }
        }
    }
    
    @ViewBuilder
    private func ProfileImage() -> some View {
        if let image = viewModel.profileImage {
            Image(uiImage: image)
                .resizable()
                .frame(maxWidth: 100, maxHeight: 100)
                .clipShape(.circle)
        } else {
            Image(systemName: "person")
        }
    }
    
    @ViewBuilder
    private func UserInfo() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Followers: \(viewModel.user.followersCount?.description ?? "N/A")")
                
                Spacer()
                
                Text("Following: \(viewModel.user.followingCount?.description ?? "N/A")")
            }
            
            Text("Public Repositories: \(viewModel.user.publicReposCount?.description ?? "N/A")")
        }
    }
}

//#Preview {
//    GHUserView()
//}
