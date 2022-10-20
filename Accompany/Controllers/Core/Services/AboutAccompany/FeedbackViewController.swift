//
//  FeedbackViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-17.
//
import Foundation
import UIKit
import MessageUI
import SnapKit

class FeedbackViewController: UIViewController, MFMailComposeViewControllerDelegate {
  
  let titleLabel = TitleLabel(title: "Feedback", size: .medium, color: .red)
  
  let textView: UITextView = {
    let textView = UITextView()
    textView.font = .systemFont(ofSize: 16, weight: .regular)
    textView.backgroundColor = .white
    textView.textColor = #colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 1)
    textView.contentInset = UIEdgeInsets(top: 5, left: 3, bottom: 0, right: -5)
    textView.text = "If you have any problems or suggestions, please let us know."
    textView.textAlignment = .center
    textView.layer.cornerRadius = 10
    textView.translatesAutoresizingMaskIntoConstraints = false
    
    return textView
  }()
  
  let rightBarButton : UIButton = {
    let button = UIButton()
    button.setTitle("Edit", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    if isEditing {
      textView.text = textView.text == "If you have any problems or suggestions, please let us know." ? "" : textView.text
      textView.becomeFirstResponder()
      
    } else {
//      noteContent = DrNoteTextView.text == "" ? nil : DrNoteTextView.text
//      HomeViewController.currentUser.note = noteContent
//      HomeViewController().saveUserData()
    }
    textView.isUserInteractionEnabled.toggle()
  }
  
  let submitButton = PrimaryButton(title: "Submit")

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    setupLayout()
    submitButton.addTarget(self, action: #selector(submitData(_:)), for: .touchUpInside)

    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
  }
  
  @objc func didTapAdd() {
    textView.resignFirstResponder()
  }
  
  @objc func submitData(_ sender: UIButton) {
    //TODO: Receive one automatically email from Accompany
    
    if MFMailComposeViewController.canSendMail() {
      print("can send email")
      let mail = MFMailComposeViewController()
      mail.mailComposeDelegate = self
      mail.setToRecipients(["appaccompany@gmail.com"])
      mail.setSubject("Accompany Feedback")
      mail.setMessageBody("<p>\(String(describing: textView.text ?? ""))</p>", isHTML: true)
      present(mail, animated: true)
      } else {
            // show failure alert
      }
     textView.text = "Thank you, we will review your feedback. Have a nice day"
  }
  
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
      print("Email was sent")
      controller.dismiss(animated: true)
  }
  
  func setupLayout() {
    view.addSubview(titleLabel)
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    
    view.addSubview(textView)
    
    textView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(15)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.8)
      make.height.equalTo(textView.snp.width).multipliedBy(0.7)
    }
    
    view.addSubview(submitButton)
    
    submitButton.snp.makeConstraints { make in
      make.top.equalTo(textView.snp.bottom).offset(25)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.3)
    }
    
  }
   
}
