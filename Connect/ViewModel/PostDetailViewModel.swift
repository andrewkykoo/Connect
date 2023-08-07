//
//  PostDetailViewModel.swift
//  Connect
//
//  Created by Andrew Koo on 8/7/23.
//

import Foundation

class PostDetailViewModel {
    private let post: Post

    init(post: Post) {
        self.post = post
    }

    var creatorName: String {
        return "\(post.creator.firstName) \(post.creator.lastName)"
    }

    var creatorLocation: String {
        return post.creator.location
    }

    var postDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: post.createdDate)
    }

    var postTitle: String {
        return post.title
    }

    var postContent: String {
        return post.content
    }
    
    var postChannel: String {
        return post.channel.name
    }
}
