//
//  AddNoteTableViewCell.swift
//  Accompany
//
//  Created by Kelbin David on 2022-02-10.
//

import UIKit
import SnapKit

class ToDoBasicInfoCell : UITableViewCell {

  let isCompleteButton: UIButton = {
    let circle = UIImage(systemName: "circle")
    let button = UIButton()
    button.setImage(circle, for: .normal)
    button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
    button.isSelected = false
    button.setContentHuggingPriority(.init(rawValue: 251), for: .horizontal)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()
  
  var toDoTextView : UITextView = {
    let textView = UITextView()
    textView.textAlignment = .left
    textView.font = .boldSystemFont(ofSize: 18)
    textView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: -5, right: -5)
    textView.translatesAutoresizingMaskIntoConstraints = false
    
    return textView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    let stackView = UIStackView(arrangedSubviews: [isCompleteButton, toDoTextView] )
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 10
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(stackView)
    
    stackView.snp.makeConstraints { make in
      make.edges.equalTo(self.contentView).inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    for subview in toDoTextView.subviews {
      if let toDoTextFieldLabel = subview as? UILabel {
        toDoTextFieldLabel.numberOfLines = 0
      }
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
