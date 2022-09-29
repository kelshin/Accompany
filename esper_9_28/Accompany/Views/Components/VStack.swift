//
//  VStack.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-16.
//

import UIKit

class VStack: UIStackView {

  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    self.translatesAutoresizingMaskIntoConstraints = false
    self.axis = .vertical
    self.distribution = .fill
    self.alignment = .fill
    self.spacing = 30
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
