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
        
        var user1 = User(firstName: "Andrew", lastName: "Koo", location: "New York, NY", email: "connect-ios-app-test@gmail.com", instagram: "https://www.instagram.com/apple/", facebook: "https://www.facebook.com/apple", twitter: "https://twitter.com/apple?lang=en", posts: [])
        var user2 = User(firstName: "Usain", lastName: "Bolt", location: "Sherwood Content, Jamaica", email: "connect-ios-app-test@gmail.com", instagram: "https://www.instagram.com/apple/", facebook: "https://www.facebook.com/apple", twitter: "https://twitter.com/apple?lang=en",posts: [])
        var user6 = User(firstName: "Sean", lastName: "Maddison", location: "Brooklyn, NY", email: "connect-ios-app-test@gmail.com", instagram: "https://www.instagram.com/apple/", facebook: "https://www.facebook.com/apple", twitter: "https://twitter.com/apple?lang=en",posts: [])
        
        var post1 = Post(channel: channel1, creator: user1, title: "We're looking for new members!", content: "Our group runs every Wednesday 7-9pm Central Park. Come out and run with us together! Come out and run with us together! Come out and run with us together!", createdDate: Date(), comments: [])
        var post2 = Post(channel: channel1, creator: user2, title: "Anybody interested in running every Monday morning?", content: "Looking for running buddies preferrably early mornings before work", createdDate: Date(), comments: [])
        var post6 = Post(channel: channel1, creator: user6, title: "I am looking for running buddies (5K or more)", content: "NYC Full marathon is two months away! Let's get in shape by running every Saturday morning around Central Park and Brooklyn.", createdDate: Date(), comments: [])
        
        user1.posts = [post1]
        user2.posts = [post2]
        user6.posts = [post6]
        channel1.posts = [post1, post2, post6]

        
        var channel2 = Channel(name: "#sundaysoccer", posts: [])
        
        var user3 = User(firstName: "Kevin", lastName: "De Bruyne", location: "Manchester, UK", email: "connect-ios-app-test@gmail.com", instagram: "https://www.instagram.com/apple/", facebook: "https://www.facebook.com/apple", twitter: "https://twitter.com/apple?lang=en",posts: [])
        var user4 = User(firstName: "Ruben", lastName: "Dias", location: "Manchester, UK", email: "connect-ios-app-test@gmail.com", instagram: "https://www.instagram.com/apple/", facebook: "https://www.facebook.com/apple", twitter: "https://twitter.com/apple?lang=en",posts: [])
        
        var post3 = Post(channel: channel2, creator: user3, title: "I am looking for a competitive league team", content: "I played at college level, play midfield, and can participate in weekly trainings.", createdDate: Date(), comments: [])
        var post4 = Post(channel: channel2, creator: user4, title: "Our team needs a midfielder for Sunday game", content: "Looking for a midfielder for our league game. The game starts at 9:00am.", createdDate: Date(), comments: [])
        
        
        user3.posts = [post3]
        user4.posts = [post4]
        channel2.posts = [post3, post4]
        
        channels.append(channel1)
        channels.append(channel2)
    }
    
    // MARK: - Data Methods
    
    func getAllChannels() -> [Channel] {
        return channels
    }
    
    func getAllPosts() -> [Post] {
        // Gather all posts from all channels
        var allPosts: [Post] = []
        for channel in channels {
            if let posts = channel.posts {
                allPosts.append(contentsOf: posts)
            }
        }
        return allPosts
    }
}
