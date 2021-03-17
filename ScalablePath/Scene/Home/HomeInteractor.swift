//
//  HomeInteractor.swift
//  ScalablePath
//
//  Created by Ana Leticia Camargos on 17/03/21.
//

import Foundation

protocol HomeBusinessLogic {
    func onViewDidLoad()
}

final class HomeInteractor {
    
    // MARK: - Dependencies
    
    weak var viewController: HomeDisplayLogic?
    private let service: PostServiceProvider
    
    // MARK: - Initializer
    
    init(service: PostServiceProvider) {
        self.service = service
    }
    
    // MARK: - Private Methods
    
    private func loadPosts() {
        viewController?.displayViewState(.loading)
        service.getPosts { [weak self] result in
            switch result {
            case let .success(entities):
                self?.handleSuccess(entities: entities)
            case .failure:
                self?.viewController?.displayViewState(.error)
            }
        }
    }
    
    private func handleSuccess(
        entities: [PostResponseEntity]
    ) {
        let viewData = entities.map {
            Home.ViewData(postTitle: $0.title, authorName: "Test", postContent: $0.body)
        }
        viewController?.displayViewState(.content(viewData))
    }
}

extension HomeInteractor: HomeBusinessLogic {
    
    func onViewDidLoad() {
        loadPosts()
    }
}
