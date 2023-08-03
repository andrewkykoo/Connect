//
//  DataManager.swift
//  Connect
//
//  Created by Andrew Koo on 8/3/23.
//

import Foundation

class DataManager {

    static let shared = DataManager() // Singleton instance

    // Mock Data
    private var channels: [Channel] = []

    private init() {
        // Load the mock data when the DataManager is created
        loadMockData()
    }

    // Load Mock Data
    private func loadMockData() {
        var channel1 = Channel(name: "#socialrunning", posts: [])
        
        var post1 = Post(channel: channel1, title: "We're looking for new members!", content: "Our group runs every Wednesday 7-9pm Central Park. Come out and run with us together!", createdDate: Date(), comments: [])
        let comment1 = Comment(post: post1, content: "Awesome! See you guys next Wednesday :)", createdDate: Date())
        let comment2 = Comment(post: post1, content: "How many miles do you run?", createdDate: Date())
        
        channel1.posts = [post1]
        post1.comments = [comment1, comment2]
        channels.append(channel1)
    }

    // MARK: - Data Methods

    func getChannels() -> [Channel] {
        return channels
    }
}
