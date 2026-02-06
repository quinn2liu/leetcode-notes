//
//  ContentView.swift
//  interview projects
//
//  Created by Quinn Liu on 1/31/26.
//

import SwiftUI

struct ContentView: View {
    
    @State var path: NavigationPath = NavigationPath()
    
    var body: some View {
        TabView {
            Tab {
                GHUserContentView()
            } label: {
                Label("GitHub User", systemImage: "square.and.arrow.up.fill")
            }
            
            Tab {
                PostsBrowserContentView()
            } label: {
                Label("Posts Browser", systemImage: "person")
            }

        }
    }
}

#Preview {
    ContentView()
}
