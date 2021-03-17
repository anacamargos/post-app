//
//  HomeViewController.swift
//  ScalablePath
//
//  Created by Ana Leticia Camargos on 17/03/21.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayViewState(_ viewState: Home.ViewState)
}

final class HomeViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private let interctor: HomeBusinessLogic
    
    // MARK: - View Components
    
    var contentView: HomeContentViewProtocol?
    
    // MARK: - Initializers
    
    init(interctor: HomeBusinessLogic) {
        self.interctor = interctor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interctor.onViewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        view = HomeContentView()
        contentView = view as? HomeContentViewProtocol
    }
}

extension HomeViewController: HomeDisplayLogic {
    
    func displayViewState(_ viewState: Home.ViewState) {
        contentView?.setupViewState(viewState)
    }
}
