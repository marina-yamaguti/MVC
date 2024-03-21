//
//  MainCoordinator.swift
//  MVC
//
//  Created by Luciana Lemos on 21/03/24.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let view = MoviesView()
        view.coordinator = self
        navigationController.pushViewController(view, animated: false)
    }
    
    func goToDetails(movie: Movie) {
        let view = MovieDetailsView()
        view.coordinator = self
        navigationController.pushViewController(view, animated: true)
    }
}
