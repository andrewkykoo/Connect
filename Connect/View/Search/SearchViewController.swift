//
//  SearchViewController.swift
//  Connect
//
//  Created by Andrew Koo on 8/3/23.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Connect"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "search, discover, and network"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        button.setTitle("Create a channel", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(createChannelButtonTapped), for: .touchUpInside)
        button.isHidden = true // Initially hidden
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    private let viewModel = SearchViewModel()
    private var filteredChannels: [Channel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name("ChannelAdded"), object: nil)
        
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
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(createChannelButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            searchBar.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
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
        let alertController = UIAlertController(title: "Create a Channel", message: "Enter the new channel name:", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Channel name"
        }
        let createChannelAction = UIAlertAction(title: "Create", style: .default) { [weak self, weak alertController] _ in
            guard let channelName = alertController?.textFields?.first?.text, !channelName.isEmpty else { return }
            self?.createChannel(named: channelName)
        }
        alertController.addAction(createChannelAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
    
    private func createChannel(named name: String) {
        let newChannel = Channel(name: "#\(name)", posts: [])
        DataManager.shared.addChannel(newChannel)
        NotificationCenter.default.post(name: Notification.Name("ChannelAdded"), object: nil)
        searchBar.text = ""
        searchBar(searchBar, textDidChange: "")
        
        let channelPostsViewModel = ChannelPostsViewModel(channel: newChannel)
        let channelViewController = PostSummaryViewController(postsViewModel: channelPostsViewModel)
        
        navigationController?.pushViewController(channelViewController, animated: true)
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
        let channelPostsViewModel = ChannelPostsViewModel(channel: selectedChannel)
        let channelViewController = PostSummaryViewController(postsViewModel: channelPostsViewModel)
        navigationController?.pushViewController(channelViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
