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
            
            window.rootViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }

}
