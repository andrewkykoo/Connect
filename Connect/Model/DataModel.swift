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
    var posts: [Post]
}

struct Post {
    let id = UUID()
    let channel: Channel
    let title: String
    let content: String
    let createdDate: Date
    var comments: [Comment]
}

struct Comment {
    let id = UUID()
    let post: Post
    let content: String
    let createdDate: Date
}


