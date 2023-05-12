//
//  PopupViewController.swift
//  Accompany
//
//  Created by Esperanza on 2022-09-09.
//

import UIKit
import SnapKit

// MARK: - View Controller

/// A view viewcontrllor that holds a popUpFormView and its user interactions.
class PopupViewController: UIViewController {
 
  // MARK: - Property
  
  /// An instance of  popUpFormView.
  let popUpFormView = PopUpFormView()
  
  // MARK: - Initializer
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    view.addSubview(popUpFormView)
   
    // MARK: - User Interactions
    
    popUpFormView.answerButton.addTarget(self, action: #selector(goToAnsVC), for: .touchUpInside)
    popUpFormView.notSureButton.addTarget(self, action: #selector(goToTabVC), for: .touchUpInside)
  }
  
  /// A function that is called when users hit the `answer` button.
  @objc func goToAnsVC() {
    let ansVC = AnsDueDateViewController()
    ansVC.modalPresentationStyle = .fullScreen
    present(ansVC, animated: true)
    }
  
  /// A function that is called when users hit the `not sure` button.
  @objc func goToTabVC() {
    dismiss(animated: true,completion: nil)
    HomeViewController().saveUserData()
  }
}
