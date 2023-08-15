//
//  SearchViewController.swift
//  Connect
//
//  Created by Andrew Koo on 8/3/23.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    private let viewModel = SearchViewModel()
    private var filteredChannels: [Channel] = []
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "type # to explore"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let createChannelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Channel not found.. Let's create one!", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(createChannelButtonTapped), for: .touchUpInside)
        button.isHidden = true // Initially hidden
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name("ChannelAdded"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name("PostAdded"), object: nil)
        
        searchBar.delegate = self
        customizeSearchBarAppearance()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ChannelTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .none
        
        setupUI()
    }
    
    @objc private func reloadData() {
        searchBar(searchBar, textDidChange: searchBar.text ?? "")
    }
    
    func presentCreateChannelViewController() {
        let createChannelVC = CreateChannelViewController()
        createChannelVC.delegate = self
        DispatchQueue.main.async {
            self.present(createChannelVC, animated: true, completion: nil)
        }
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(createChannelButton)
        createChannelButton.addTarget(self, action: #selector(createChannelButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            createChannelButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            createChannelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func customizeSearchBarAppearance() {
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    }
    
    @objc private func createChannelButtonTapped() {
        presentCreateChannelViewController()
    }
    
    // MARK: - UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredChannels = []
            createChannelButton.isHidden = true
        } else {
            filteredChannels = viewModel.filterChannels(with: searchText)
            createChannelButton.isHidden = filteredChannels.isEmpty == false
        }
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredChannels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChannelTableViewCell
        let channel = filteredChannels[indexPath.row]
        cell.channelNameLabel.text = channel.name
        
        if let posts = channel.posts, !posts.isEmpty {
            cell.postCountLabel.text = "\(posts.count) post\(posts.count == 1 ? "" : "s")"
        } else {
            cell.postCountLabel.text = "0 posts"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedChannel = filteredChannels[indexPath.row]
        let channelViewController = ChannelViewController(selectedChannel: selectedChannel)
        navigationController?.pushViewController(channelViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController: CreateChannelDelegate {
    func createChannel(channelName: String) {
        let newChannel = Channel(name: "#\(channelName)", posts: [])
        DataManager.shared.addChannel(newChannel)
        NotificationCenter.default.post(name: Notification.Name("ChannelAdded"), object: nil)
        searchBar.text = ""
        searchBar(searchBar, textDidChange: "")
    
        let channelViewController = ChannelViewController(selectedChannel: newChannel)
        
        navigationController?.pushViewController(channelViewController, animated: true)
    }
}
