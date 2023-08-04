//
//  SearchViewModel.swift
//  Connect
//
//  Created by Andrew Koo on 8/3/23.
//

import Foundation

class SearchViewModel {
    
    private let dataManager = DataManager.shared
    private var channels: [Channel] = []
    
    init() {
        channels = dataManager.getChannels()
    }
    
    func filterChannels(with searchText: String) -> [Channel] {
        if searchText.isEmpty {
            return channels
        } else {
            return channels.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}
