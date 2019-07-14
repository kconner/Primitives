//
//  SceneDelegate.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
            
            let primitiveListViewController = navigationController.topViewController as! PrimitiveListViewController
            primitiveListViewController.configure(
                with: PrimitiveListViewModel(
                    catalog: .init(),
                    favorites: .init(),
                    settings: .init()
                )
            )
            
            window.rootViewController = navigationController
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }

}
