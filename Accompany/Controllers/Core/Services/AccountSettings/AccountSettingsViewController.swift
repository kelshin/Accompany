//
//  AccountSettingsViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-17.
//

import UIKit

enum AccountSettings: String {
  case privacyPolicy = "Privacy Policy"
  case termsOfUse = "Terms Of Use"
  case feedback = "Feedback"
}

class AccountSettingsViewController: UIViewController {
  
  let titleLabel = TitleLabel(title: Services.settings.description, size: .medium)
  
  let privacyPolicyButton = PrimaryButton(title: AccountSettings.privacyPolicy.rawValue)
  let termsOfUseButton = PrimaryButton(title: AccountSettings.termsOfUse.rawValue)
  let feedbackButton = PrimaryButton(title: AccountSettings.feedback.rawValue)
  
  let bgImage = ImageView()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    bgImage.image = UIImage(named: "grey-bg")
    setupTitle()
    setupVStack()
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(
      title: Services.settings.description, style: .plain, target: nil, action: nil)
  }
  
  private func setupTitle() {
    view.addSubview(titleLabel)
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    
    view.addSubview(bgImage)
    
    bgImage.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(25)
      make.centerX.equalTo(view)
      make.left.equalTo(view.safeAreaLayoutGuide)
      make.right.equalTo(view.safeAreaLayoutGuide)
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(2)
    }
  }
  
  private func setupVStack() {
    let vStack = VStack(arrangedSubviews: [generateButtonsVStack()])
    
    view.addSubview(vStack)
    vStack.snp.makeConstraints { make in
      make.top.equalTo(bgImage.snp.top).offset(80)
      make.centerX.equalTo(view.safeAreaLayoutGuide)
      make.width.equalTo(view.snp.width).multipliedBy(0.55)
    }
  }
  
  private func generateButtonsVStack() -> VStack {
    let buttons = [privacyPolicyButton, termsOfUseButton, feedbackButton]
    buttons.forEach { button in
      button.snp.makeConstraints { make in
        make.width.equalTo(200)
      }
      
      button.addTarget(self, action: #selector(goTo(_:)), for: .touchUpInside)
    }
    
    let vStack = VStack(arrangedSubviews: buttons)
    vStack.alignment = .center
    
    return vStack
  }
  
  @objc func goTo(_ button: UIButton) {
    switch button {
    case privacyPolicyButton:
      navigationController?.pushViewController(PrivacyPolicyViewController(), animated: true)
    case termsOfUseButton:
      navigationController?.pushViewController(TermsOfUseViewController(), animated: true)
    case feedbackButton:
      navigationController?.pushViewController(FeedbackViewController(), animated: true)
//    case deleteAccountButton:
//      // TODO: Prompt confirm delete message
//      // TODO: Back to Sign up Page
//      print(AccountSettings.deleteAccount.rawValue)
    default:
      return
    }
  }
  
//  @objc func switchValueChanged() {
//    // TODO: change user's notification setting
//  }
    
}
