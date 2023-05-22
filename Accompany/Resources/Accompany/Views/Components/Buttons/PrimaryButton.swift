//
//  PrimaryButton.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-16.
//

import UIKit

class PrimaryButton: UIButton {

  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init(title: String) {
    self.init(frame: .zero)
    self.setTitle(title, for: .normal)
    self.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    self.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3882352941, blue: 0.5333333333, alpha: 1)
    self.layer.cornerRadius = 16
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
