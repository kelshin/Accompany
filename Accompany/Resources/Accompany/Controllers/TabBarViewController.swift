//
//  TabBarViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit

// MARK: - View Controller

/// A view controller that we handle the tab bar view.
class TabBarViewController: UITabBarController {

  // MARK: - Enum
  
  /// A enum type for different titles of a view controller.
  enum TabBarVCTitle: String {
    /// Feature `Home` that users can view the todo items.
    case home = "Home"
    /// Feature `Our Baby` that users can know how many days are left until the birth.
    case ourBaby = "Our Baby"
    /// Feature `Record`: In this feature, users can upload their photos, use contraction timer to record their contractions, and take notes.
    case record = "Record"
    /// Feature `Timer`that users can use contraction timer to record their contractions.
    case timer = "Timer"
    /// Feature `Service` that users can set up their profile and send a feedback mail.
    case service = "Service"
  }
  
  // MARK: - viewDidLoad method
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    self.tabBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    configureViewControllers()
  }
  
  // MARK: - Private Method
  
  /**
   Configures the view controllers for the tab bar.
   
   This method creates and configures the view controllers to be displayed in the tab bar.
   Each view controller is assigned a tab bar item with a title and an associated image.
   */
  private func configureViewControllers() {
    let homeVC = HomeViewController()
    homeVC.tabBarItem = UITabBarItem(title: "\(TabBarVCTitle.home.rawValue)",
                                     image: UIImage(named: "home-menu-icon"), tag: 1)
    let ourBabyVC = OurBabyViewController()
    ourBabyVC.tabBarItem = UITabBarItem(title: "\(TabBarVCTitle.ourBaby.rawValue)",
                                        image: UIImage(named: "our-baby-icon"), tag: 1)
    let recordsVC = RecordsViewController()
    recordsVC.tabBarItem = UITabBarItem(title: "\(TabBarVCTitle.record.rawValue)",
                                        image: UIImage(named: "record-menu-icon"), tag: 1)
    let contractionTimerVC = ContractionTimerViewController()
    contractionTimerVC.tabBarItem = UITabBarItem(title: "\(TabBarVCTitle.timer.rawValue)",
                                                 image: UIImage(named: "timer-menu-icon"), tag: 1)
    let serviceVC = ServiceViewController()
    serviceVC.tabBarItem = UITabBarItem(title: "\(TabBarVCTitle.service.rawValue)",
                                        image: UIImage(named: "service-menu-icon"), tag: 1)
    let vcs = [homeVC, ourBabyVC, recordsVC, contractionTimerVC, serviceVC]
    self.viewControllers = vcs.map { UINavigationController(rootViewController: $0) }
  }
}
