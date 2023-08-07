//
//  ChannelPostsViewModel.swift
//  Connect
//
//  Created by Andrew Koo on 8/7/23.
//

import Foundation

class ChannelPostsViewModel {
    private let channel: Channel
    private var allPosts: [Post] = []

    var filteredPosts: [Post] {
        return allPosts.filter { $0.channel.name == channel.name }
    }
    
    init(channel: Channel) {
        self.channel = channel
        self.fetchAllPosts()
    }
    
    var channelName: String {
        return channel.name
    }
    
    private func fetchAllPosts() {
        allPosts = DataManager.shared.getAllPosts()
    }
    
    func filterPosts(with searchText: String) -> [Post] {
        if searchText.isEmpty {
            return filteredPosts
        } else {
            return filteredPosts.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    
}
