//
//  ProfileDetailViewController.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-22.
//
import UIKit

protocol ProfileDetailViewControllerDelegate {
  func edit(_ value: String, for field: InfoField)
}

class ProfileDetailViewController: CustomTextViewController {
  
  var delegate: ProfileDetailViewControllerDelegate?

  let confirmButton = OutlineButton(title: "Confirm")
  
  var field: InfoField?
  var fieldValue: String?

  override func viewDidLoad() {
    super.viewDidLoad()
     
    textView.textAlignment = .left
    
    confirmButton.addTarget(self, action: #selector(pressBtn), for: .touchUpInside)
    setupLayout()
    updateConfirmButtonState()

  }
  
  @objc func pressBtn() {
    delegate?.edit(textView.text ?? "", for: field!)
    navigationController?.popViewController(animated: true)
  }
  
  func setupLayout() {
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.centerX.equalTo(view)
    }
    
    view.addSubview(textView)
    
    textView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(30)
      make.width.equalTo(view.snp.width)
      make.height.equalTo(textView.snp.width).multipliedBy(0.3)
    }
    
    view.addSubview(confirmButton)
    
    confirmButton.snp.makeConstraints { make in
      make.top.equalTo(textView.snp.bottom).offset(20)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.3)
      make.height.equalTo(confirmButton.snp.width).multipliedBy(0.3)
    }
  }
  
  func updateUI(_ field: InfoField) {
    
    // update title and placeholder
    title = "Edit \(field.rawValue)"
    
    switch field {
    case .username:
      textView.text = fieldValue!
    case .email:
      textView.text = fieldValue!
    case .babyName:
      textView.text = fieldValue!
    case .statusMessage:
      textView.text = fieldValue!
    case .bio:
      textView.text = fieldValue!
    default:
      return
    }
    
  }
  
  private func updateConfirmButtonState() {
    // check if username is not empty
    if field == InfoField.username {
      confirmButton.isEnabled = !textView.text.isEmpty
//    } else if field == InfoField.email {
//      // check if email is not empty && is validate
//      confirmButton.isEnabled = !textView.text.isEmpty && isValidEmail(textView.text)
    }
  }
}
