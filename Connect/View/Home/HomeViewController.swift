//
//  HomeViewController.swift
//  Connect
//
//  Created by Andrew Koo on 8/9/23.
//

import UIKit

protocol TabBarDelegate: AnyObject {
    func didSelectChannel(_ channel: Channel)
}

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    weak var tabBarDelegate: TabBarDelegate?
    
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
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var channels: [Channel] {
        return DataManager.shared.getAllChannels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name("ChannelAdded"), object: nil)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ChannelTableViewCell.self, forCellReuseIdentifier: "ChannelCell")
        tableView.separatorStyle = .none
        
        setupUI()
    }
    
    @objc private func reloadData() {
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath) as! ChannelTableViewCell
        let channel = channels[indexPath.row]
        cell.channelNameLabel.text = channel.name
        cell.postCountLabel.text = "\(channel.posts?.count ?? 0) post\(channel.posts?.count == 1 ? "" : "s")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
        cell.alpha = 0

        UIView.animate(
            withDuration: 1.5,
            delay: 0.5 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = .identity
                cell.alpha = 1
            })
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedChannel = channels[indexPath.row]
        tabBarDelegate?.didSelectChannel(selectedChannel)

        let channelViewController = ChannelViewController(channel: selectedChannel)
        channelViewController.title = "Channel"
        channelViewController.tabBarItem.image = UIImage(systemName: "globe")
        channelViewController.tabBarItem.selectedImage = UIImage(systemName: "globe.fill")

        navigationController?.pushViewController(channelViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

