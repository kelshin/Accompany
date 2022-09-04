//
//  PhotoDetailedViewController.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-17.
//

import UIKit

class PhotoDetailedViewController: UIViewController {
  
  let imageView = ImageView()
  let deleteImage = ImageView()


  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
//    imageView.image = UIImage(named: "logo-app")
    imageView.backgroundColor = .white
    imageView.layer.borderWidth = 1.0
    imageView.layer.masksToBounds = false
    imageView.layer.borderColor = #colorLiteral(red: 1, green: 0.8831380575, blue: 0.9568627451, alpha: 1)
    
    deleteImage.image = UIImage(systemName: "trash.fill")
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
    deleteImage.isUserInteractionEnabled = true
    deleteImage.addGestureRecognizer(tapGestureRecognizer)
  
    setupLayout()
  }
  
  @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
    
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (_) in
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
    }))
    
    self.present(alert, animated: true, completion: {
    })
    
  }
  
  func setupLayout() {
    
    view.addSubview(imageView)
    
    imageView.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.centerY.equalTo(view)
      make.width.equalTo(view.snp.width)
      make.height.equalTo(view.snp.height).multipliedBy(0.44)
    }
    
    view.addSubview(deleteImage)
    
    deleteImage.snp.makeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(20)
      make.centerX.equalTo(view)
      make.width.equalTo(25)
      make.height.equalTo(25)
    }
    
  }
 
}
