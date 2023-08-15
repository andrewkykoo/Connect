//
//  CreatePostViewController.swift
//  Connect
//
//  Created by Andrew Koo on 8/14/23.
//

import UIKit

class CreatePostViewController: UIViewController, UITextViewDelegate {
    
    private let textFieldHeight: CGFloat = 40
    private let textViewHeight: CGFloat = 150
    
    private let subjectLabel: UILabel = {
        let label = UILabel()
        label.text = "Subject:"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subjectTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1.0
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "Content:"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textColor = .black // Set the text color
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5.0
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // ... Other properties and methods ...
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        contentTextView.delegate = self
        
        view.addSubview(subjectLabel)
        view.addSubview(subjectTextField)
        view.addSubview(contentLabel)
        view.addSubview(contentTextView)
        view.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            subjectLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            subjectLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            subjectTextField.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor, constant: 8),
            subjectTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subjectTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            subjectTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            contentLabel.topAnchor.constraint(equalTo: subjectTextField.bottomAnchor, constant: 20),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            contentTextView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 8),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentTextView.heightAnchor.constraint(equalToConstant: textViewHeight),
            
            submitButton.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc private func submitButtonTapped() {
        // Handle the submit button tap here
        // Retrieve values from text fields and create a new post
        // You can use delegate pattern or any other communication method to notify the ChannelViewController about the new post
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidChange(_ textView: UITextView) {
        // Automatically adjust the content size to fit the text
        let sizeToFit = CGSize(width: textView.frame.width, height: .infinity)
        let newSize = textView.sizeThatFits(sizeToFit)
        textView.frame.size = CGSize(width: max(newSize.width, sizeToFit.width), height: newSize.height)
    }
}

