//
//  PhotoDetailedViewController.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-17.
//

import UIKit

class PhotoDetailedViewController: UIViewController {
  
  var imageView = ImageView()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    imageView.layer.masksToBounds = false
    imageView.layer.borderColor = #colorLiteral(red: 1, green: 0.8831380575, blue: 0.9568627451, alpha: 1)
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
  
    setupLayout()
  }
  
  func setupLayout() {
    
    view.addSubview(imageView)
    
    imageView.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.centerY.equalTo(view)
      make.width.equalTo(view.snp.width)
      make.height.equalTo(view.snp.height).multipliedBy(0.6)
    }
      
  }
  
}


