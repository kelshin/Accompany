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
  case deleteAccount = "Delete Account"
  
}

class AccountSettingsViewController: UIViewController {
  
  let titleLabel = TitleLabel(title: Services.accountSettings.description, size: .medium)
  
  let notificationLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Notifications"
    label.font = .systemFont(ofSize: 17, weight: .regular)
    label.setContentHuggingPriority(UILayoutPriority(250), for: .horizontal)
    
    return label
  }()
  
  let notificationSwitch: UISwitch = {
    let notificationSwitch = UISwitch()
    notificationSwitch.translatesAutoresizingMaskIntoConstraints = false
    notificationSwitch.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
    notificationSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    
    return notificationSwitch
  }()
  
  let lineSeperator: UIView = {
    let line = UIView()
    line.translatesAutoresizingMaskIntoConstraints = false
    line.backgroundColor = .systemGray4
    
    line.snp.makeConstraints { make in
      make.height.equalTo(3)
    }
    
    return line
  }()
  
  let privacyPolicyButton = PrimaryButton(title: AccountSettings.privacyPolicy.rawValue)
  let termsOfUseButton = PrimaryButton(title: AccountSettings.termsOfUse.rawValue)
  let feedbackButton = PrimaryButton(title: AccountSettings.feedback.rawValue)
  let deleteAccountButton = OutlineButton(title: AccountSettings.deleteAccount.rawValue)

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    deleteAccountButton.addTarget(self, action: #selector(deleteAlert(_:)), for: .touchUpInside)
    
    setupTitle()
    setupVStack()
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(
      title: Services.accountSettings.description, style: .plain, target: nil, action: nil)
  }
  
  @objc func deleteAlert(_ sender: UIButton) {
    let alert = UIAlertController(title: "Delete this account?", message: "Deleting this account will also delete its data.", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
    alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  
  private func setupTitle() {
    view.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
  }
  
  private func setupVStack() {
    let hStack = UIStackView(arrangedSubviews: [notificationLabel, notificationSwitch])
    hStack.translatesAutoresizingMaskIntoConstraints = false
    hStack.axis = .horizontal
    hStack.alignment = .fill
    hStack.distribution = .fill
    hStack.spacing = 20
    
    let vStack = VStack(arrangedSubviews: [hStack, lineSeperator, generateButtonsVStack()])
    
    view.addSubview(vStack)
    vStack.snp.makeConstraints { make in
      make.centerY.equalTo(view).offset(-20)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.7)
    }
  }
  
  private func generateButtonsVStack() -> VStack {
    let buttons = [privacyPolicyButton, termsOfUseButton, feedbackButton, deleteAccountButton]
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
    case deleteAccountButton:
      // TODO: Prompt confirm delete message
      // TODO: Back to Sign up Page
      print(AccountSettings.deleteAccount.rawValue)
    default:
      return
    }
  }
  
  @objc func switchValueChanged() {
    // TODO: change user's notification setting
  }
    
}
