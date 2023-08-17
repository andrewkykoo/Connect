//
//  CreatePostViewController.swift
//  Connect
//
//  Created by Andrew Koo on 8/14/23.
//

import UIKit

class CreatePostViewController: UIViewController, UITextViewDelegate {
    
    private let selectedChannel: Channel
    private let textFieldHeight: CGFloat = 40
    private let textViewHeight: CGFloat = 150
    
    init(selectedChannel: Channel) {
        self.selectedChannel = selectedChannel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        textView.textColor = .label 
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
        guard let subject = subjectTextField.text, !subject.isEmpty,
              let content = contentTextView.text, !content.isEmpty else {
            let alertController = UIAlertController(title: "Missing Info", message: "Please fill in both fields", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            return
        }
        
        let newPost = Post(channel: selectedChannel, creator: User(firstName: "John", lastName: "Wick", location: "New York, NY"), title: subject, content: content, createdDate: Date(), comments: [])
        
        DataManager.shared.addPost(newPost, to: selectedChannel)
        NotificationCenter.default.post(name: Notification.Name("PostAdded"), object: nil)
        let newChannelViewController = ChannelViewController(selectedChannel: selectedChannel)
            navigationController?.pushViewController(newChannelViewController, animated: true)
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidChange(_ textView: UITextView) {
        // Automatically adjust the content size to fit the text
        let sizeToFit = CGSize(width: textView.frame.width, height: .infinity)
        let newSize = textView.sizeThatFits(sizeToFit)
        textView.frame.size = CGSize(width: max(newSize.width, sizeToFit.width), height: newSize.height)
    }
}

