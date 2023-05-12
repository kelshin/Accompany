//
//  AnsDueDateViewController.swift
//  Accompany
//
//  Created by Esperanza on 2022-09-09.
//

import UIKit
import SnapKit

protocol AnsDueDateViewControllerDelegateProtocol {
  func sendDataToHomeVC(data: String)
  
}

class AnsDueDateViewController: UIViewController {
  var delegate: AnsDueDateViewControllerDelegateProtocol? = nil
  
  let container: UIView = {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    container.backgroundColor = .white
    container.layer.cornerRadius = 24
    return container
  }()
  
  let dueDatePicker: UIDatePicker = {
    let dueDatePicker = UIDatePicker()
    dueDatePicker.timeZone = NSTimeZone.local
    dueDatePicker.backgroundColor = .white
    dueDatePicker.translatesAutoresizingMaskIntoConstraints = false
    dueDatePicker.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    return dueDatePicker
  }()
  
  let dueDateInput: UITextField = {
    let dueDateInput = UITextField()
    dueDateInput.translatesAutoresizingMaskIntoConstraints = false
    dueDateInput.placeholder = "MM-DD-YYYY"
    dueDateInput.borderStyle = UITextField.BorderStyle.roundedRect
    dueDateInput.font = UIFont.systemFont(ofSize: 15)
    dueDateInput.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3882352941, blue: 0.5333333333, alpha: 1)
    dueDateInput.textColor = .black
    return dueDateInput
  }()
  
  let backBtn = OutlineButton(title: "Back")
  let doneBtn = OutlineButton(title: "Done")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    setupLayout()
    createDatePicker()

    backBtn.addTarget(self, action: #selector(goBackPopVC), for: .touchUpInside)
    doneBtn.addTarget(self, action: #selector(goToHomeVC), for: .touchUpInside)
  }

  private func setupLayout() {
    view.addSubview(container)
    container.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.centerY.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.7)
      make.height.equalTo(view.snp.height).multipliedBy(0.2)
    }
    
    let btnHStack = UIStackView(arrangedSubviews: [doneBtn,backBtn])
    btnHStack.translatesAutoresizingMaskIntoConstraints = false
    btnHStack.axis = .horizontal
    btnHStack.distribution = .fillEqually
    btnHStack.alignment = .center
    btnHStack.spacing = 5
    
    let answerVStack = UIStackView(arrangedSubviews: [dueDateInput, btnHStack])
    answerVStack.translatesAutoresizingMaskIntoConstraints = false
    answerVStack.axis = .vertical
    answerVStack.distribution = .equalCentering
    answerVStack.alignment = .fill
    answerVStack.spacing = 2
    
    container.addSubview(answerVStack)
    answerVStack.snp.makeConstraints { make in
      make.centerX.equalTo(container)
      make.centerY.equalTo(container)
      make.width.equalTo(container.snp.width).multipliedBy(0.8)
      make.height.equalTo(container.snp.height).multipliedBy(0.6)
      
    }
    
  }
  
  private func createToolbar() -> UIToolbar {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
    toolbar.setItems([doneBtn], animated: true)
    
    return toolbar
  }
  
  private func createDatePicker() {
    dueDatePicker.preferredDatePickerStyle = .wheels
    dueDatePicker.datePickerMode = .date
    dueDatePicker.minimumDate = NSCalendar.current.date(byAdding: .day, value: +0, to: Date())
    dueDateInput.inputView = dueDatePicker
    dueDateInput.inputAccessoryView = createToolbar()
    dueDateInput.textAlignment = .center
  }
  
  @objc func donePressed() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    self.dueDateInput.text = dateFormatter.string(from: dueDatePicker.date)
    self.view.endEditing(true)
  }
  
  @objc func goBackPopVC() {
    let popVC = PopupViewController()
    popVC.modalPresentationStyle = .fullScreen
    present(popVC, animated: true)
  }
  
  // MARK: Pass the data to count trimester
  @objc func goToHomeVC() {
    if (dueDateInput.text == "") {
      let alert = UIAlertController(title: "Have to choose the date", message: "If you don't know the date, you can press back and choose don't know button.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
      }))
      self.present(alert, animated: true, completion: {
      })
      } else {
        HomeViewController.currentUser.detailsInfo?.dueDate = dueDatePicker.date
        HomeViewController().saveUserData()
        self.view.window!.rootViewController?.dismiss(animated: true)
      }
  }
  
}
  
