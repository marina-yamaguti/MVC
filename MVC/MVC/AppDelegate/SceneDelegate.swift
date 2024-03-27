//
//  SceneDelegate.swift
//  MVC
//
//  Created by Marina Yamaguti on 18/03/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow()
        window?.frame = windowScene.coordinateSpace.bounds
        window?.windowScene = windowScene
        let navigation = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigation)
        coordinator?.start()
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
