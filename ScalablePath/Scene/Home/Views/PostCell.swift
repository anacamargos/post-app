//
//  PostCell.swift
//  ScalablePath
//
//  Created by Ana Leticia Camargos on 17/03/21.
//

import UIKit

final class PostCell: UITableViewCell {
    
    // MARK: - View Components
    
    private let postTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = .zero
        return label
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = .zero
        return label
    }()
    
    private let postContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = .zero
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(postTitleLabel)
        addSubview(authorNameLabel)
        addSubview(postContentLabel)
    }
    
    private func addConstraints() {
        constrainPostTitleLabel()
        constrainAuthorNameLabel()
        constrainPostContentLabel()
    }
    
    private func constrainPostTitleLabel() {
        NSLayoutConstraint.activate([
            postTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            postTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            postTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func constrainAuthorNameLabel() {
        NSLayoutConstraint.activate([
            authorNameLabel.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: 16),
            authorNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            authorNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func constrainPostContentLabel() {
        NSLayoutConstraint.activate([
            postContentLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 16),
            postContentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            postContentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            postContentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Public Methods
    
    func setupViewData(_ viewData: Home.ViewData) {
        postTitleLabel.text = viewData.postTitle
        authorNameLabel.text = viewData.authorName
        postContentLabel.text = viewData.postContent
    }
}

enum Home {
    
    enum ViewState {
        case loading
        case empty
        case error
        case content([ViewData])
    }
    
    struct ViewData {
        let postTitle: String
        let authorName: String
        let postContent: String
    }
}
