//
//  SceneDelegate.swift
//  rick
//
//  Created by Svetlana Arturovnaa on 04.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Properties
    
    var window: UIWindow?
    
    // MARK: - Functions
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let splashContr = SplashVC()
        
        window.rootViewController = splashContr
        self.window?.makeKeyAndVisible()
    }
}


