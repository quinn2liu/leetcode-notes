//
//  GHUser.swift
//  interview projects
//
//  Created by Quinn Liu on 2/6/26.
//

import Foundation

struct GHUser: Hashable, Codable, Identifiable {
    var id: Int
    var username: String
    var urlString: String
    var imageUrlString: String
    var followersUrlString: String
    var followingUrlString: String
    var reposUrlString: String
    var publicReposCount: Int?
    var followersCount: Int?
    var followingCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "login"
        case urlString = "url"
        case imageUrlString = "avatar_url"
        case followersUrlString = "followers_url"
        case followingUrlString = "following_url"
        case reposUrlString = "repos_url"
        case followersCount = "followers"
        case followingCount = "following"
        case publicReposCount = "public_repos"
    }
}

//{
//    "login": "railsjitsu",
//    "id": 32,
//    "node_id": "MDQ6VXNlcjMy",
//    "avatar_url": "https://avatars.githubusercontent.com/u/32?v=4",
//    "gravatar_id": "",
//    "url": "https://api.github.com/users/railsjitsu",
//    "html_url": "https://github.com/railsjitsu",
//    "followers_url": "https://api.github.com/users/railsjitsu/followers",
//    "following_url": "https://api.github.com/users/railsjitsu/following{/other_user}",
//    "gists_url": "https://api.github.com/users/railsjitsu/gists{/gist_id}",
//    "starred_url": "https://api.github.com/users/railsjitsu/starred{/owner}{/repo}",
//    "subscriptions_url": "https://api.github.com/users/railsjitsu/subscriptions",
//    "organizations_url": "https://api.github.com/users/railsjitsu/orgs",
//    "repos_url": "https://api.github.com/users/railsjitsu/repos",
//    "events_url": "https://api.github.com/users/railsjitsu/events{/privacy}",
//    "received_events_url": "https://api.github.com/users/railsjitsu/received_events",
//    "type": "User",
//    "user_view_type": "public",
//    "site_admin": false
//},
