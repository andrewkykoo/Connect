//
//  CreateChannelViewController.swift
//  Connect
//
//  Created by Andrew Koo on 8/14/23.
//

import UIKit

protocol CreateChannelDelegate: AnyObject {
    func createChannel(channelName: String)
}

class CreateChannelViewController: UIViewController {

    weak var delegate: CreateChannelDelegate?

    private let channelNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter channel name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create", for: .normal)
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Create Channel"

        view.addSubview(channelNameTextField)
        view.addSubview(createButton)

        NSLayoutConstraint.activate([
            channelNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            channelNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            channelNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            channelNameTextField.heightAnchor.constraint(equalToConstant: 40),

            createButton.topAnchor.constraint(equalTo: channelNameTextField.bottomAnchor, constant: 20),
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    @objc private func createButtonTapped() {
        guard let channelName = channelNameTextField.text, !channelName.isEmpty else {
            return
        }

        delegate?.createChannel(channelName: channelName)
        dismiss(animated: true, completion: nil)
    }
}

