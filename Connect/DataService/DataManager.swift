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
        let post2 = Post(channel: channel1, title: "Anybody interested in running every Monday morning?", content: "Looking for running buddies preferrably early mornings before work", createdDate: Date(), comments: [])
        let comment1 = Comment(post: post1, content: "Awesome! See you guys next Wednesday :)", createdDate: Date())
        let comment2 = Comment(post: post1, content: "How many miles do you run?", createdDate: Date())
        
        channel1.posts = [post1, post2]
        post1.comments = [comment1, comment2]
        
        var channel2 = Channel(name: "#sundaysoccer", posts: [])
        
        var post3 = Post(channel: channel2, title: "I am looking for a competitive league team", content: "I played at college level, play midfield, and can participate in weekly trainings.", createdDate: Date(), comments: [])
        let comment3 = Comment(post: post3, content: "Our team has a tryout this Saturday. Want to join?", createdDate: Date())
        let comment4 = Comment(post: post3, content: "Do you only play midfield?", createdDate: Date())
        
        channel2.posts = [post3]
        post3.comments = [comment3, comment4]
        
        channels.append(channel1)
        channels.append(channel2)
    }

    // MARK: - Data Methods

    func getChannels() -> [Channel] {
        return channels
    }
}
