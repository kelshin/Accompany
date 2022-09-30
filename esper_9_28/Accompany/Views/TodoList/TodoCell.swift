//
//  TodoCell.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-10.
//

import UIKit
import SnapKit

protocol TodoCellDelegate {
  func isCompleteButtonTapped(sender: TodoCell)
}

class TodoCell: UITableViewCell {
  
  static let identifier = "TodoCell"
  
  var delegate: TodoCellDelegate?
    
  let isCompleteButton : UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "circle"), for: .normal)
    button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
    button.isUserInteractionEnabled = true
    button.isSelected = false
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()

  let titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.numberOfLines = 0
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    return titleLabel
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
      
    let stackView = UIStackView(arrangedSubviews: [isCompleteButton, titleLabel])
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 10
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.centerY.equalTo(contentView)
      make.left.equalTo(contentView).offset(10)
      make.right.equalTo(contentView).offset(-10)
    }
    
    isCompleteButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(with todo: Todo) {
    self.isCompleteButton.isSelected = todo.isCompleted
    self.titleLabel.text = todo.title
    self.titleLabel.textColor = .black
  }
  
  @objc func buttonTapped(sender: UIButton) {
    sender.isSelected.toggle()
    delegate?.isCompleteButtonTapped(sender: self)
  }
    
}

