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

  // MARK: - fileprivate properties

  /// A fileprivate property that represents a UIButton view named as "Answer".
  let answerButton = OutlineButton(title: "Answer")

  /// A fileprivate property that represents a UIButton view named as "Not sure".
  let notSureButton = OutlineButton(title: "Not sure")

  /// A fileprivate property that represents a UIStackView containing two UIButton views.
  fileprivate lazy var optionsButtonsStack: UIStackView = {
    let buttonStack = UIStackView(arrangedSubviews: [answerButton, notSureButton])
    buttonStack.translatesAutoresizingMaskIntoConstraints = false
    buttonStack.axis = .horizontal
    buttonStack.distribution = .fillEqually
    buttonStack.alignment = .center
    buttonStack.spacing = 5
    return buttonStack
  }()

  /// A fileprivate property that
  fileprivate lazy var questionVStackView: UIStackView = {
    let questionStack = UIStackView(arrangedSubviews: [questionTitlesVStackView, optionsButtonsStack])
    questionStack.translatesAutoresizingMaskIntoConstraints = false
    questionStack.axis = .vertical
    questionStack.distribution = .fillEqually
    return questionStack
  }()

  // MARK: - Initializers

  /// An override init method that builds up a view.
  /// - Parameter frame: Size of the view.
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    self.frame = UIScreen.main.bounds
    self.addSubview(popUpContentView)

    popUpContentView.snp.makeConstraints { make in
      make.centerX.equalTo(self)
      make.centerY.equalTo(self)
      make.width.equalTo(self.snp.width).multipliedBy(0.7)
      make.height.equalTo(self.snp.height).multipliedBy(0.3)
    }

    popUpContentView.addSubview(questionVStackView)
    questionVStackView.snp.makeConstraints { make in
      make.centerX.equalTo(self.popUpContentView.snp.centerX)
      make.centerY.equalTo(self.popUpContentView.snp.centerY)
      make.width.equalTo(self.popUpContentView.snp.width).multipliedBy(0.85)
      make.height.equalTo(self.popUpContentView.snp.height)
    }
  }

  /// A required initializer used when an object needs to be initialized from data in an archive.
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
