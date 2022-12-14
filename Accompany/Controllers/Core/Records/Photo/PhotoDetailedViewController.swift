//
//  PhotoDetailedViewController.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-17.
//

import UIKit
import SnapKit

class PhotoDetailedViewController: UIViewController, UIScrollViewDelegate {
  
  var scrollView = UIScrollView()
  
  var imageView = ImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    let vHeight = self.view.frame.height
    let vWidth = self.view.frame.width

    scrollView.frame = CGRectMake(0, 0, vWidth, vHeight)
    scrollView.alwaysBounceVertical = false
    scrollView.alwaysBounceHorizontal = false
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.flashScrollIndicators()
    scrollView.minimumZoomScale = 1.0
    scrollView.maximumZoomScale = 6.0
    scrollView.delegate = self
//    scrollView.backgroundColor = .black

    view.addSubview(scrollView)
    
    scrollView.snp.makeConstraints { make in
      make.centerY.centerX.equalTo(view)
      make.width.equalTo(view.snp.width)
      make.height.equalTo(view.snp.height)
//      make.bottom.equalTo()
    }
    
    scrollView.addSubview(imageView)
    
    let tabBarHeight = Int((tabBarController?.tabBar.frame.height)!)
    imageView.clipsToBounds = false
    imageView.contentMode = .scaleAspectFit
    imageView.snp.makeConstraints { make in
//      make.centerY.equalTo(self.scrollView.snp.centerY)
//      make.centerX.equalTo(self.scrollView.snp.centerX)
      make.width.equalTo(scrollView.snp.width)
      make.height.equalTo(scrollView.snp.height).inset(tabBarHeight + 10)
    }
    
    
    print(view.frame.height)
    print(scrollView.frame.height)
//    print(tabBarController?.tabBar.frame.height)
  }

  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageView
  }
}
