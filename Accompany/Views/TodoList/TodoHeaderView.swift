//
//  TodoHeaderView.swift
//  Assignment6
//
//  Created by Mark Wong on 2022-01-13.
//

import UIKit
import SnapKit

class TodoHeaderView: UITableViewHeaderFooterView {
  
  static let identifier = "TodoHeaderView"
  
  var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 20, weight: .regular)
    label.text = "🔺Weekly Tasks:"
    
    return label
  }()
    
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(titleLabel)
    // TODO: Fix header layout error in console
    titleLabel.snp.makeConstraints { make in
      make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 2, left: 10, bottom: 0, right: 0))
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
