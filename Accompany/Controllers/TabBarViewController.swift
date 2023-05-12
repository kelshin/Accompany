//
//  TabBarViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit

class TabBarViewController: UITabBarController {
  
  enum TabBarVCTitle: String {
    case home = "Home"
    case ourBaby = "Our Baby"
    case records = "Record"
    case timer = "Timer"
    case services = "Service"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)

    configureViewControllers()
    
    self.tabBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
  }
  
  private func configureViewControllers() {
    let homeVC = HomeViewController()
    homeVC.tabBarItem = UITabBarItem(title: "\(TabBarVCTitle.home.rawValue)", image: UIImage(named: "home-menu-icon"), tag: 1)

    let ourBabyVC = OurBabyViewController()
    ourBabyVC.tabBarItem = UITabBarItem(title: "\(TabBarVCTitle.ourBaby.rawValue)", image: UIImage(named: "our-baby-icon"), tag: 1)
    
    let recordsVC = RecordsViewController()
    recordsVC.tabBarItem = UITabBarItem(title: "\(TabBarVCTitle.records.rawValue)", image: UIImage(named: "record-menu-icon"), tag: 1)
    
    let contractionTimerVC = ContractionTimerViewController()
    contractionTimerVC.tabBarItem = UITabBarItem(title: "\(TabBarVCTitle.timer.rawValue)", image: UIImage(named: "timer-menu-icon"), tag: 1)
    
    let serviceVC = ServiceViewController()
    serviceVC.tabBarItem = UITabBarItem(title: "\(TabBarVCTitle.services.rawValue)", image: UIImage(named: "service-menu-icon"), tag: 1)
    
    let vcs = [homeVC, ourBabyVC, recordsVC, contractionTimerVC, serviceVC]
    
    self.viewControllers = vcs.map { UINavigationController(rootViewController: $0) }
  }

}
