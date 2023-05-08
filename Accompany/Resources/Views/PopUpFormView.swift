//
//  PopUpFormView.swift
//  Accompany
//
//  Created by Esperanza on 2022-09-08.
//

import Foundation
import UIKit
import SnapKit

// MARK: - UIView

/// An UI View that represents the pop up form view for the users.
public class PopUpFormView: UIView {
  
  // MARK: - Private Properties
  
  /// Creates an UIView that represents the content view on the screen.
  private let popUpContentView: UIView = {
    let contentView = UIView()
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.backgroundColor = .white
    contentView.layer.cornerRadius = 24
    return contentView
  }()
  
  /// Creates an UILable view that shows the tile of the pop up content view.
  private let questionTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    label.text = "Question"
    label.textAlignment = .center
    return label
  }()
  
  /// Creates an UILabel view that shows the question of the pop up content view.
  private let dueDateQuestionTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    label.text = "When is the due date of your baby?"
    label.textAlignment = .center
    label.numberOfLines = 2
    return label
  }()
  
  /// Creates a VStack view that contains two UILabel views.
  private lazy var questionTitlesVStackView: UIStackView = {
    let VTitleStack = UIStackView(arrangedSubviews: [questionTitleLabel, dueDateQuestionTitleLabel])
    VTitleStack.translatesAutoresizingMaskIntoConstraints = false
    VTitleStack.axis = .vertical
    VTitleStack.spacing = 0.5
    return VTitleStack
  }()
  
  fileprivate let dueDateAnsBtn = PrimaryButton(title: "Answer")
  fileprivate let dontKnowBtn = PrimaryButton(title: "Dont't know")

  
//  fileprivate let dueDateInput: UITextField = {
//    let dueDateInput = UITextField()
//    dueDateInput.translatesAutoresizingMaskIntoConstraints = false
//    dueDateInput.placeholder = "dd/mm/yyyy"
//    dueDateInput.borderStyle = UITextField.BorderStyle.roundedRect
//    dueDateInput.font = UIFont.systemFont(ofSize: 15)
//    return dueDateInput
//  }()
  
  fileprivate lazy var HBtnStack: UIStackView = {
    let HBtnStack = UIStackView(arrangedSubviews: [dueDateAnsBtn, dontKnowBtn])
    HBtnStack.translatesAutoresizingMaskIntoConstraints = false
    HBtnStack.axis = .horizontal
    HBtnStack.distribution = .fillEqually
    HBtnStack.alignment = .center
    HBtnStack.spacing = 5
    return HBtnStack
  }()
  
  fileprivate lazy var qaStack: UIStackView = {
    let qaStack = UIStackView(arrangedSubviews: [questionTitlesVStackView, HBtnStack])
    qaStack.translatesAutoresizingMaskIntoConstraints = false
    qaStack.axis = .vertical
    qaStack.distribution = .fillEqually
    return qaStack
    
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    self.frame = UIScreen.main.bounds
    self.addSubview(popUpContentView)
    popUpContentView.snp.makeConstraints { make in
      make.centerX.equalTo(self)
      make.centerY.equalTo(self)
      make.width.equalTo(self.snp.width).multipliedBy(0.8)
      make.height.equalTo(self.snp.height).multipliedBy(0.3)
    }
    
    popUpContentView.addSubview(qaStack)
    qaStack.snp.makeConstraints { make in
      make.centerX.equalTo(self.popUpContentView.snp.centerX)
      make.centerY.equalTo(self.popUpContentView.snp.centerY)
      make.width.equalTo(self.popUpContentView.snp.width).multipliedBy(0.8)
      make.height.equalTo(self.popUpContentView.snp.height).multipliedBy(0.9)
    }
//    container.addSubview(VTitleStack)
//    VTitleStack.snp.makeConstraints { make in
//      make.leading.equalTo(self.container.snp.leading)
//      make.trailing.equalTo(self.container.snp.trailing)
//      make.height.equalTo(self.container.snp.height).multipliedBy(0.5)
//    }
//
//    container.addSubview(HBtnStack)
//    HBtnStack.snp.makeConstraints { make in
//      make.leading.equalTo(self.container.snp.leading)
//      make.trailing.equalTo(self.container.snp.trailing)
//      make.top.equalTo(self.VTitleStack.snp.bottom).offset(10)
//      make.width.equalTo(self.container.snp.width).multipliedBy(0.5)
//      make.height.equalTo(self.container.snp.height).multipliedBy(0.4)
//    }
    
//    container.addSubview(dueDateInput)
//    dueDateInput.snp.makeConstraints { make in
//      make.bottom.equalTo(self.container.snp.bottom).offset(-10)
//      make.width.equalTo(self.container.snp.width).multipliedBy(0.8)
//      make.height.equalTo(self.container.snp.height).multipliedBy(0.2)
////      make.leading.equalTo(self.container.snp.leading)
////      make.trailing.equalTo(self.container.snp.trailing)
//      make.centerX.equalTo(self.container.snp.centerX)
//      make.centerY.equalTo(self.container.snp.centerY)
//    }
  }
  
  
//  @objc func goToHomePage(_ button: UIButton) {
//    let homeVC = HomeViewController()
//
//    navigationController?.pushViewController(homeVC, animated: true)
//
//  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
