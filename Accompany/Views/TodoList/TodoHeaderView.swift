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
    label.font = .systemFont(ofSize: 18, weight: .bold)
    label.textAlignment = .left
    label.text = "To Do Lists:"
    label.textColor = #colorLiteral(red: 0.9921568627, green: 0.3882352941, blue: 0.5333333333, alpha: 1)
    
    return label
  }()
    
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(titleLabel)
    // TODO: Fix header layout error in console
//    titleLabel.snp.makeConstraints { make in
//      make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 10, left: 12, bottom: 0, right: 0))
//    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
