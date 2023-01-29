//
//  SceneDelegate.swift
//  iAcronyms
//
//  Created by Prateek Juneja on 26/01/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        coordinator = MainCoordinator()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = coordinator?.setUpInitialNavigation()
        window?.makeKeyAndVisible()
    }

}

