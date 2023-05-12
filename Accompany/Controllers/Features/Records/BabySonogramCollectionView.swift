//
//  BabySonogramCollectionView.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-14.
//

import UIKit
import PhotosUI

class BabySonogramCollectionView: UICollectionView, PHPickerViewControllerDelegate {
  
  let babyTitleLabel: BabySonogramTitleLabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    view.addSubview(babyTitleLabel)
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressAdd))
  }
  

  

}
