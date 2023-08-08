//
//  DataModel.swift
//  Connect
//
//  Created by Andrew Koo on 8/3/23.
//

import Foundation

struct Channel {
    let id = UUID()
    let name: String
    var posts: [Post]?
}

struct Post {
    let id = UUID()
    let channel: Channel
    let creator: User
    let title: String
    let content: String
    let createdDate: Date
    var comments: [Comment]
}

struct Comment {
    let id = UUID()
    let channel: Channel
    let post: Post
    let creator: User
    let content: String
    let createdDate: Date
}

struct User {
    let id = UUID()
    let firstName: String
    let lastName: String
    let location: String
    let email: String
    let instagram: String?
    let facebook: String?
    let twitter: String?
    var posts: [Post]?
}
