//
//  TabBaViewController.swift
//  SplitVC
//
//  Created by Yassine DAOUDI on 30/12/2021.
//

import UIKit

class TabBaViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        TabBarItems()
        view.backgroundColor = .systemGreen
    }
    
    func configureTabBar() {
        viewControllers = [SplitViewController(style: .unspecified)]
        tabBar.items?[0].image = UIImage(systemName: "house.fill")
        tabBar.items?[0].title = "Home"
        
        tabBar.selectionIndicatorImage = UIImage(named: "Selected")
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 30
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        additionalSafeAreaInsets.bottom = 20
        tabBar.tintColor = .systemGreen
        tabBar.backgroundColor = .white.withAlphaComponent(0.01)
    }
    
    
    func TabBarItems() {
        tabBar.items?[0].image = UIImage(systemName: "house.fill")
        tabBar.items?[0].title = "Home"
    }
}
