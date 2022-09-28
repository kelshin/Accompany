//
//  TextView.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-21.
//

import UIKit

class TextView: UITextView {

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    self.text = text
    self.font = .systemFont(ofSize: 16, weight: .regular)
    self.backgroundColor = .white
    self.textAlignment = .left
    self.layer.cornerRadius = 10
    self.isEditable = true
    self.isSelectable = true
    self.translatesAutoresizingMaskIntoConstraints = false
    textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)

    if let text = text {
      self.text = text
    }
    
  }

}
