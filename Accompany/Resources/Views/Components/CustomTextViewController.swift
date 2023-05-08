//
//  CustomTextViewController.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-22.
//

import UIKit

class CustomTextViewController: UIViewController {
  
  let titleLabel = TitleLabel(title: nil, size: .medium, color: .red)
  
  let textView: UITextView = {
    let textView = UITextView()
    textView.font = .systemFont(ofSize: 16, weight: .regular)
    textView.backgroundColor = .white
    textView.textColor = #colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 1)
    textView.contentInset = UIEdgeInsets(top: 5, left: 3, bottom: 0, right: -5)
    textView.translatesAutoresizingMaskIntoConstraints = false
    
    return textView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    view.addSubview(titleLabel)
  }
  
}

extension CustomTextViewController {
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    textView.resignFirstResponder() //keyboard
  }
  
//  @objc func keyboardWasShown(notification: NSNotification) {
//    let info = notification.userInfo
//    
//    if let keyboardRect = info?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect {
//      
//      let keyboardSize = keyboardRect.size
//      textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
//      textView.scrollIndicatorInsets = textView.contentInset
//    }
//  }
//  
//  @objc func keyboardWillBeHidden(notification: NSNotification) {
//    textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    textView.scrollIndicatorInsets = textView.contentInset
//  }

}
