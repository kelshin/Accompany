//
//  PopupViewController.swift
//  Accompany
//
//  Created by Esperanza on 2022-09-09.
//

import UIKit
import SnapKit

class PopupViewController: UIViewController {
  
  let container: UIView = {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    container.backgroundColor = .white
    container.layer.cornerRadius = 24
    return container
  }()
  
  let titleLable: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    label.text = "Question"
    label.textAlignment = .center
    return label
  }()
  
 let subtitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    label.text = "When is the due date of your baby?"
    label.textAlignment = .center
    label.numberOfLines = 3
    return label
  }()
  
  let dueDateAnsBtn = OutlineButton(title: "Answer")
  let dontKnowBtn = OutlineButton(title: "Dont't know")
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
   
    setupLayout()
    
  }
    
  func setupLayout() {
    view.addSubview(container)
    container.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.centerY.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.8)
      make.height.equalTo(view.snp.height).multipliedBy(0.3)
    }
   
    let HBtnStack = UIStackView(arrangedSubviews: [dueDateAnsBtn, dontKnowBtn])
    HBtnStack.translatesAutoresizingMaskIntoConstraints = false
    HBtnStack.axis = .horizontal
    HBtnStack.distribution = .fillEqually
    HBtnStack.alignment = .center
    HBtnStack.spacing = 5
    
    dueDateAnsBtn.addTarget(self, action: #selector(goToAnsVC), for: .touchUpInside)
    dontKnowBtn.addTarget(self, action: #selector(goToTabVC), for: .touchUpInside)

    let VTitleStack = UIStackView(arrangedSubviews: [titleLable, subtitleLabel])
    VTitleStack.translatesAutoresizingMaskIntoConstraints = false
    VTitleStack.axis = .vertical
    VTitleStack.spacing = 0.5

    let qaStack = UIStackView(arrangedSubviews: [VTitleStack, HBtnStack])
    qaStack.translatesAutoresizingMaskIntoConstraints = false
    qaStack.axis = .vertical
    qaStack.distribution = .fillEqually
    
    container.addSubview(qaStack)
    qaStack.snp.makeConstraints { make in
      make.centerX.equalTo(container.snp.centerX)
      make.centerY.equalTo(container.snp.centerY)
      make.width.equalTo(container.snp.width).multipliedBy(0.8)
      make.height.equalTo(container.snp.height).multipliedBy(0.9)
    }
   
  }
  
  @objc func goToAnsVC() {
    let ansVC = AnsDueDateViewController()
    let navVC = UINavigationController(rootViewController: ansVC)
    navVC.modalPresentationStyle = .fullScreen
    present(navVC, animated: true)
    
    }
  
  @objc func goToTabVC() {
    let tabBarVC = TabBarViewController()
    view.window?.rootViewController = tabBarVC
  }

}
