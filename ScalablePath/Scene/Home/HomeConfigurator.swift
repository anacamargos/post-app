//
//  HomeConfigurator.swift
//  ScalablePath
//
//  Created by Ana Leticia Camargos on 17/03/21.
//

import UIKit

final class HomeConfigurator {
    
    func resolveViewController() -> UIViewController {
        let service = PostService(urlSession: URLSession.shared)
        let interactor = HomeInteractor(service: service)
        let viewController = HomeViewController(interctor: interactor)
        interactor.viewController = viewController
        return viewController
    }
}
