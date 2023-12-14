//
//  SplashVC.swift
//  rick
//
//  Created by Svetlana Arturovnaa on 10.12.2023.
//

import UIKit

class SplashVC: UIViewController {
    
    // MARK: - Private Properties
    
    private let rmLaunchPic = UIImageView()
    private let portalLaunchPic = UIImageView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        timer()
        setRmPic()
        setPortalPic()
        rotatePortal()
    }

    // MARK: - Private functions
    
    private func setRmPic() {
        rmLaunchPic.image = UIImage(named: "rickLogo")
        view.addSubview(rmLaunchPic)
        
        rmLaunchPic.translatesAutoresizingMaskIntoConstraints = false
        rmLaunchPic.topAnchor.constraint(equalTo: view.topAnchor, constant: 97).isActive = true
        rmLaunchPic.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34).isActive = true
        rmLaunchPic.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17).isActive = true
    }
    
    private func setPortalPic() {
        portalLaunchPic.image = UIImage(named: "LoadingLogo")
        portalLaunchPic.contentMode = .scaleAspectFill
        view.addSubview(portalLaunchPic)
        
        portalLaunchPic.translatesAutoresizingMaskIntoConstraints = false
        portalLaunchPic.topAnchor.constraint(equalTo: rmLaunchPic.bottomAnchor, constant: 146).isActive = true
        portalLaunchPic.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 81).isActive = true
        portalLaunchPic.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -82).isActive = true
    }
    
    private func rotatePortal() {
        portalLaunchPic.rotate360Degrees()
    }
    
    private func timer() {
        let tabBarContr = TabBarVC()
        let interval: TimeInterval = 3
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            let navTabBar = UINavigationController(rootViewController: tabBarContr)
            navTabBar.modalPresentationStyle = .fullScreen
            self.present(navTabBar, animated: true)
        }
    }
}

// MARK: - Extension

extension UIView {
    
    func rotate360Degrees(duration: CFTimeInterval = 3.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate as? any CAAnimationDelegate
        }
        self.layer.add(rotateAnimation, forKey: nil)
    }
}
