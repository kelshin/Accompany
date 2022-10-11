//
//  ServiceViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit

enum AccountSettings: String {
  case privacyPolicy = "Privacy Policy"
  case termsOfUse = "Terms Of Use"
  case feedback = "Feedback"
}

enum Services: CustomStringConvertible, CaseIterable {
  
  case myProfile
  case privacyPolicy
  case termsOfUse
  case aboutAccompany
  case feedback
  
  var description: String {
    switch self {
    case .myProfile:
      return "My Profile"
    case .privacyPolicy:
      return "Privacy Policy"
    case .termsOfUse:
      return "Terms Of Use"
    case .aboutAccompany:
      return "About Accompany"
    case .feedback:
      return "Feedback"
    }
  }

}

class ServiceViewController: UIViewController {
  
  let titleLabel = TitleLabel(title: "Service", size: .large, color: .red)
  
  let bgImage = ImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bgImage.image = UIImage(named: "grey-bg")

    setupLayout()
    setupButtons()
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "Service", style: .plain, target: nil, action: nil)
        
  }
  
  private func setupLayout() {
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
  
  private func setupButtons() {
    var buttons = [UIButton]()
    for i in 0..<Services.allCases.count {
      switch i {
      case 0 :
        buttons.append(SecondaryButton(title: Services.allCases[i].description))
      case 1, 2, 3:
        buttons.append(PrimaryButton(title: Services.allCases[i].description))
      case 4:
        buttons.append(OutlineButton(title: Services.allCases[i].description))
      default:
        return
      }

//      buttons[i].addTarget(self, action: #selector(goTo(_:)), for: .touchUpInside)
    }
    
    buttons.forEach { $0.addTarget(self, action: #selector(goTo(_:)), for: .touchUpInside) }
    
    let vStack = VStack(arrangedSubviews: buttons)
    view.addSubview(vStack)
    
    vStack.snp.makeConstraints { make in
      make.top.equalTo(bgImage.snp.top).offset(80)
      make.centerX.equalTo(view.safeAreaLayoutGuide)
      make.width.equalTo(view.snp.width).multipliedBy(0.55)
    }
  }
  
  @objc func goTo(_ button: UIButton) {
    switch button.titleLabel?.text {
    case Services.myProfile.description:
      let myProfileVC = MyProfileViewController()
      navigationController?.pushViewController(myProfileVC, animated: true)
    case Services.privacyPolicy.description:
      navigationController?.pushViewController(PrivacyPolicyViewController(), animated: true)
    case Services.termsOfUse.description:
      navigationController?.pushViewController(TermsOfUseViewController(), animated: true)
    case Services.aboutAccompany.description:
      navigationController?.pushViewController(AboutAccompanyViewController(), animated: true)
    case Services.feedback.description:
      navigationController?.pushViewController(FeedbackViewController(), animated: true)
      
    default:
      return
    }
    
  }
    
}
