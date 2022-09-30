//
//  DatePickerTableViewCell.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-24.
//

import UIKit
import SnapKit

class DatePickerTableViewCell: UITableViewCell {

  static let identifier = "DatePickerTableViewCell"
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 12, weight: .bold)
    label.textColor = .gray
    label.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
    
    return label
  }()
   
  let datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    datePicker.preferredDatePickerStyle = .compact
    datePicker.backgroundColor = .white
    
    return datePicker
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    titleLabel.text = InfoField.dueDate.rawValue
    titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
    titleLabel.textColor  = #colorLiteral(red: 0.2462079227, green: 0.2246411145, blue: 0.2394523323, alpha: 1)
    datePicker.datePickerMode = .date
    datePicker.maximumDate = NSCalendar.current.date(byAdding: .day, value: -1, to: Date())
    
    let hStack: UIStackView = {
      let hStack = UIStackView(arrangedSubviews: [titleLabel, datePicker])
      hStack.axis = .horizontal
      hStack.distribution = .fill
      hStack.alignment = .fill
      hStack.spacing = 10
      hStack.translatesAutoresizingMaskIntoConstraints = false
      
      return hStack
    }()
    
    contentView.addSubview(hStack)
    
    // TODO: set constraints...
    hStack.snp.makeConstraints { make in
      make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 10))
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
