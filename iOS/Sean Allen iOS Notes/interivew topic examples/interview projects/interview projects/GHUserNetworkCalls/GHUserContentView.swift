//
//  GHUserContentView.swift
//  interview projects
//
//  Created by Quinn Liu on 1/31/26.
//

import SwiftUI

struct GHUserContentView: View {
    
//    @State var ghPath: NavigationPath = NavigationPath()
    @StateObject var ghUserListViewModel: GHUserListViewModel
    var userService: GHUserServicing = GHUserService()
    
    init(userService: GHUserServicing = GHUserService()) {
        _ghUserListViewModel = StateObject(wrappedValue: GHUserListViewModel(userService: userService))
        self.userService = userService
    }
    
    
    var body: some View {
        NavigationStack {
            GHUserListView(viewModel: ghUserListViewModel)
                .navigationDestination(for: GHUser.self) { user in
                    GHUserDetailView(user: user, userService: userService)
                }
        }
    }
}

#Preview {
    GHUserContentView()
}
