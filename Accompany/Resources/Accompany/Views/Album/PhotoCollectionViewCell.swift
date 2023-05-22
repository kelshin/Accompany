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
    contentView.backgroundColor = .white
    contentView.addSubview(photoView)
    
    photoView.contentMode = .scaleAspectFill
    photoView.clipsToBounds = true

    photoView.snp.makeConstraints { make in
      make.left.equalTo(contentView.snp.left)
      make.right.equalTo(contentView.snp.right)
      make.top.equalTo(contentView.snp.top)
      make.bottom.equalTo(contentView.snp.bottom)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
