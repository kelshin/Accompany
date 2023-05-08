//
//  ProfileCell.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-22.
//
import UIKit

class ProfileCell: UITableViewCell {
  
  static let identifier = "ProfileCell"
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 16, weight: .bold)
    label.textColor = #colorLiteral(red: 0.2462079227, green: 0.2246411145, blue: 0.2394523323, alpha: 1)
    label.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
    
    return label
  }()

  let contentLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 18, weight: .regular)
    label.textColor = #colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 1)
    
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let hStack = VStack(arrangedSubviews: [titleLabel, contentLabel])
    hStack.axis = .horizontal
    
    addSubview(hStack)
    
    hStack.snp.makeConstraints { make in
      make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 10))
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(with value: String, for field: InfoField) {
    self.titleLabel.text = "\(field.rawValue): "
    self.contentLabel.text = value
  }

}
