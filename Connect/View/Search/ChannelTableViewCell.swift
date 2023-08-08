//
//  ChannelTableViewCell.swift
//  Connect
//
//  Created by Andrew Koo on 8/3/23.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {
    
    let channelNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(channelNameLabel)
        contentView.addSubview(postCountLabel)
        
        NSLayoutConstraint.activate([
            channelNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            channelNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            postCountLabel.leadingAnchor.constraint(equalTo: channelNameLabel.leadingAnchor),
            postCountLabel.topAnchor.constraint(equalTo: channelNameLabel.bottomAnchor, constant: 4),
            postCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
