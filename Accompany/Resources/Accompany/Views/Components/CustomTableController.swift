//
//  CustomTableController.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-21.
//

import UIKit

class CustomTableController: UIViewController {
  
  let titleLabel = TitleLabel(title: nil, size: .medium, color: .red)
  
  let contentTableView: UITableView = {
    let contentTableView = UITableView()
    contentTableView.register(ContentCell.self, forCellReuseIdentifier: ContentCell.identifier)
    contentTableView.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    contentTableView.separatorStyle = .none
    
    return contentTableView
  }()

  let contentCell = ContentCell()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
  }
  
  func configureTableView() {
    contentTableView.delegate = self
  }
  
  func setupLayout() {
  
    view.addSubview(titleLabel)
     
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }

    view.addSubview(contentTableView)

    contentTableView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.9)
      make.height.equalTo(view.snp.height).multipliedBy(0.8)
    }
    
  }

}

extension CustomTableController: UITableViewDelegate {
  
}
