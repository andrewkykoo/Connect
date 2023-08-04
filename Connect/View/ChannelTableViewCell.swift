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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Setup the cell's UI elements here
        contentView.addSubview(channelNameLabel)
        
        // Add constraints to position the label within the cell
        NSLayoutConstraint.activate([
            channelNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            channelNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            channelNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            channelNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
