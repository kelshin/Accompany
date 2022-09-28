//
//  ImageView.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-17.
//

import UIKit

class ImageView: UIImageView {
 
  override init(frame: CGRect) {
    super.init(frame: .zero)
  }
  
  convenience init() {
    self.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false

  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
