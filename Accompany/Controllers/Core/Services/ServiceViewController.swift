//
//  ServiceViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit

enum Services: CustomStringConvertible, CaseIterable {
  
  case myProfile
//  case invitePartner
  case settings
//  case pregnantArticles
  case aboutAccompany
  
  var description: String {
    switch self {
    case .myProfile:
      return "My Profile"
//    case .invitePartner:
//      return "Invite Partner"
    case .settings:
      return "Settings"
//    case .pregnantArticles:
//      return "Pregnant Articles"
    case .aboutAccompany:
      return "About Accompany"
//    case .logOut:
//      return "Log Out"
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
    // My Profile
    case Services.myProfile.description:
      let myProfileVC = MyProfileViewController()
      
      // TODO: fetch user info
      
      navigationController?.pushViewController(myProfileVC, animated: true)
    // Account Settings
    case Services.settings.description:
      navigationController?.pushViewController(AccountSettingsViewController(), animated: true)
    // About Accompany
    case Services.aboutAccompany.description:
      navigationController?.pushViewController(AboutAccompanyViewController(), animated: true)
    // Log Out
//    case Services.logOut.description:
//      
//      let alert = UIAlertController(title: "Log Out of Accompany?", message: nil, preferredStyle: .alert)
//      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//      alert.addAction(UIAlertAction(title: "Log Out", style: .default, handler: { _ in
//        // TODO: Log out with database
//        print("Log out")
//        
        // back to log in page (scene delegate?)
    
  
      
//      self.present(alert, animated: true, completion: nil)
      
    default:
      return
    }
    
  }
    
}
