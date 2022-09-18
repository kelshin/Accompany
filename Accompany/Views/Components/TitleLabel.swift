//
//  TitleLabel.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-16.
//

import UIKit
import SnapKit

class TitleLabel: UILabel {
  
  enum Size {
    case mini, small, medium, large
  }
  
  enum Color {
    case red, purple, black, grey
  }

  override init(frame: CGRect) {
    super.init(frame: .zero)
  }

  convenience init(title: String?, size: Size, color: Color = .red) {
    self.init(frame: .zero)
    self.textColor = #colorLiteral(red: 0.9921568627, green: 0.3882352941, blue: 0.5333333333, alpha: 1)
    self.textAlignment = .center
    self.numberOfLines = 0
    self.translatesAutoresizingMaskIntoConstraints = false
    
    if let title = title {
      self.text = title
    }
     
    switch size {
    case .mini:
      self.font = UIFont.boldSystemFont(ofSize: 24)
//      self.font = UIFont(name: "SimpleBoy", size: 25)
    case .small:
//      self.font = UIFont.boldSystemFont(ofSize: 20)
      self.font = UIFont(name: "SimpleBoy", size: 20)
    case .medium:
      self.font = UIFont(name: "SimpleBoy", size: 50)
    case .large:
      self.font = UIFont(name: "SimpleBoy", size: 60)
    }
    
    switch color {
    case .red:
      self.textColor = #colorLiteral(red: 0.9921568627, green: 0.3882352941, blue: 0.5333333333, alpha: 1)
    case .purple:
      self.textColor = #colorLiteral(red: 0.5490196078, green: 0.4588235294, blue: 0.968627451, alpha: 1)
    case .black:
      self.textColor = #colorLiteral(red: 0.2078431373, green: 0.2039215686, blue: 0.2235294118, alpha: 1)
    case.grey:
      self.textColor = #colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 1)
    }
  
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
//  
  func setupLayout(superView: UIView) {
    self.snp.makeConstraints { make in
      make.top.equalTo(superView.safeAreaLayoutGuide).offset(30)
      make.centerX.equalTo(superView)
      make.width.equalTo(superView.snp.width).multipliedBy(0.8)
    }
  }

}
