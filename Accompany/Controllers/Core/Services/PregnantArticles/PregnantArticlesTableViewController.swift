////
////  PregnantArticlesTableViewController.swift
////  Accompany
////
////  Created by Mark Wong on 2022-02-17.
////
//
//import UIKit
//
//class PregnantArticlesTableViewController: UITableViewController {
//  
//  let articlesTitle = TitleLabel(title: Services.pregnantArticles.description, size: .medium, color: .red)
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    
//    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
// 
//    setupLayout()
//  }
//
//  // MARK: - Table view data source
//  
//  func setupLayout() {
//    view.addSubview(articlesTitle)
//    
//    articlesTitle.snp.makeConstraints { make in
//      make.top.equalTo(view.safeAreaLayoutGuide)
//      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
//      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
//    }
//  }
//
//}
