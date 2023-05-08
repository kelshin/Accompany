//
//  ToDoNotesCell.swift
//  Accompany
//
//  Created by Kelbin David on 2022-02-15.
//

import UIKit
import SnapKit

class ToDoNotesCell: UITableViewCell {
  
  let noteTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.font = .boldSystemFont(ofSize: 16)
    textView.isUserInteractionEnabled = true
  
    return textView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(noteTextView)
    noteTextView.snp.makeConstraints{(make) in
      make.edges.equalTo(0).inset(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
