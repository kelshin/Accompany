//
//  PhotoCollectionViewCell.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-15.
//

import UIKit
import SnapKit

class PhotoCollectionViewCell: UICollectionViewCell {

  static let reuseIdentifier = "photoCollectionCell"
  
  let photoView = ImageView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(photoView)
    contentView.backgroundColor = .white
    
//    photoView.image = UIImage(named: "logo-app")
    photoView.contentMode = .scaleAspectFill
    photoView.clipsToBounds = true

    photoView.snp.makeConstraints { make in
      make.left.equalTo(contentView.snp.left).offset(5)
      make.right.equalTo(contentView.snp.right).offset(-5)
      make.top.equalTo(contentView.snp.top).offset(5)
      make.bottom.equalTo(contentView.snp.bottom).offset(5)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
