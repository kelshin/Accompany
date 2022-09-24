//
//  FeedbackViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-17.
//

import UIKit
import MessageUI

class FeedbackViewController: CustomTextViewController, MFMailComposeViewControllerDelegate {
  
  let submitButton = PrimaryButton(title: "Submit")

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
       
    titleLabel.text = "Feedback"
    textView.text = "If you have any problems or suggestions, please let us know."
    textView.textAlignment = .center
    textView.layer.cornerRadius = 10
    
    submitButton.addTarget(self, action: #selector(submitData(_:)), for: .touchUpInside)
    
    setupLayout()
  }
  
  @objc func submitData(_ sender: UIButton) {
    //TODO: Receive one automatically email from Accompany
    
    if MFMailComposeViewController.canSendMail() {
      print("can send email")
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["kelbinmdavid@gmail.com"])
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
