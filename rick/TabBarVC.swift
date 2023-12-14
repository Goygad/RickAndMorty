//
//  ViewController.swift
//  rick
//
//  Created by Svetlana Arturovnaa on 04.12.2023.
//

import UIKit

final class TabBarVC: UITabBarController {
    
    // MARK: - Private Properties
    
    private let episodes = EpisodesVC()
    private let favorites = FavoritesVC()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        self.delegate = self
        
        setTabBar()
    }
    
    // MARK: - Private functions
    
    private func setTabBar() {
        self.tabBar.backgroundColor = .white
        tabBar.itemPositioning = .centered
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowColor = UIColor.gray.cgColor
        tabBar.layer.shadowOpacity = 0.2
        episodes.tabBarItem.image = UIImage(named: "HouseFill")?.withRenderingMode(.alwaysOriginal)
        favorites.tabBarItem.image = UIImage(named: "Heart")?.withRenderingMode(.alwaysOriginal)
        
        let episodesNavController = UINavigationController(rootViewController: episodes)
        let favoritesNavController = UINavigationController(rootViewController: favorites)
        
        viewControllers = [episodesNavController, favoritesNavController]
    }
}

extension TabBarVC: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if self.selectedIndex == 0 {
            episodes.tabBarItem.image = UIImage(named: "HouseFill")?.withRenderingMode(.alwaysOriginal)
        } else {
            episodes.tabBarItem.image = UIImage(named: "House")?.withRenderingMode(.alwaysOriginal)
        }
        
        if self.selectedIndex == 1 {
            favorites.tabBarItem.image = UIImage(named: "HeartFill")?.withRenderingMode(.alwaysOriginal)
        } else {
            favorites.tabBarItem.image = UIImage(named: "Heart")?.withRenderingMode(.alwaysOriginal)
        }
    }
}

