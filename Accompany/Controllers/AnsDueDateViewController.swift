//
//  AnsDueDateViewController.swift
//  Accompany
//
//  Created by Esperanza on 2022-09-09.
//

import UIKit
import SnapKit

// MARK: - Protocol

/// A protocol holds a method which can help us send the data to HomeViewController if other files conform this protocl.
protocol AnsDueDateViewControllerDelegateProtocol {
  /// A methods we pass the data as a String type to the HomeViewController.
  func sendDataToHomeVC(data: String)
}

// MARK: View Controller

/// A view controller that holds an answer due date view and its user interactions.
class AnsDueDateViewController: UIViewController {
  
  // MARK: - Property
  
  /// An instance of AnsDueDateView.
  let ansDueDateView = AnsDueDateView()
  
  // MARK: - View Conformance
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    view.addSubview(ansDueDateView)
    
    // MARK: - User Interactions
    
    ansDueDateView.backButton.addTarget(self, action: #selector(goBackPopVC), for: .touchUpInside)
    ansDueDateView.doneButton.addTarget(self, action: #selector(goToHomeVC), for: .touchUpInside)
  }
  
  /// A method is called when users hit the back button.
  @objc func goBackPopVC() {
    let popVC = PopupViewController()
    popVC.modalPresentationStyle = .fullScreen
    present(popVC, animated: true)
  }
  
  /// A method is called when users hit the done button. If users don't select a date, we will show up an alert view.
  @objc func goToHomeVC() {
    if (ansDueDateView.dueDateInput.text == "") {
      let alert = UIAlertController(title: "Have to choose a date",
                                    message: "If you're not sure your baby's due date, you can hit the back button and choose the 'not sure' button",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK",
                                    style: .default))
      self.present(alert, animated: true)
    } else {
      let alert = UIAlertController(title: nil,
                                    message: "If you want to modify your selected due date at a later time, you can do so by navigating to 'Settings' -> 'My Profile' and resetting your due date",
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK",
                                    style: .default,
                                    handler: { action in
        HomeViewController.currentUser.detailsInfo?.dueDate = self.ansDueDateView.dueDatePicker.date
        HomeViewController().saveUserData()
        self.view.window!.rootViewController?.dismiss(animated: true)
      }))
      self.present(alert, animated: true)
      }
  }
}
