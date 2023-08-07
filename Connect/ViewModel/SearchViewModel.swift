//
//  SearchViewModel.swift
//  Connect
//
//  Created by Andrew Koo on 8/3/23.
//

import Foundation

class SearchViewModel {
    
    private var channels: [Channel] = []
    
    init() {
        channels = DataManager.shared.getAllChannels()
    }
    
    func filterChannels(with searchText: String) -> [Channel] {
        if searchText.isEmpty {
            return channels
        } else {
            return channels.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}
