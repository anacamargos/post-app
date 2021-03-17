//
//  HomeContentView.swift
//  ScalablePath
//
//  Created by Ana Leticia Camargos on 17/03/21.
//

import UIKit

protocol HomeContentViewProtocol {
    func setupViewState(_ viewState: Home.ViewState)
}

final class HomeContentView: UIView {
    
    // MARK: - Properties
    
    private var viewState: Home.ViewState = .loading
    
    // MARK: - View Components
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(tableView)
    }
    
    private func addConstraints() {
        constrainTableView()
    }
    
    private func constrainTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: - HomeContentViewProtocol

extension HomeContentView: HomeContentViewProtocol {
    
    func setupViewState(_ viewState: Home.ViewState) {
        self.viewState = viewState
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableVIewDataSource UITableViewDelegate

extension HomeContentView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewState {
        case .loading, .error, .empty:
            return 1
        case let .content(viewData):
            return viewData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewState {
        case .loading:
            debugPrint("loading")
            return .init()
        case .error:
            debugPrint("error")
            return .init()
        case .empty:
            debugPrint("empty")
            return .init()
        case let .content(viewData):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else { return .init() }
            let currentViewData = viewData[indexPath.row]
            cell.setupViewData(currentViewData)
            return cell
        }
    }
}
