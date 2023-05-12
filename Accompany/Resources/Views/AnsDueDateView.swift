//
//  AnsDueDateView.swift
//  Accompany
//
//  Created by Esperanza on 2023-05-12.
//

import Foundation
import UIKit
import SnapKit

// MARK: - View

/// A view that shows up an answer due date view with its components.
public class AnsDueDateView: UIView {
  
  // MARK: - Private Properties
 
  /// Creates an UIView that represents a content view on the screen.
  private let container: UIView = {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    container.backgroundColor = .white
    container.layer.cornerRadius = 24
    return container
  }()
  
  /// Creates an UIView that represents a UIDatePicker view.
  let dueDatePicker: UIDatePicker = {
    let dueDatePicker = UIDatePicker()
    dueDatePicker.timeZone = NSTimeZone.local
    dueDatePicker.backgroundColor = .white
    dueDatePicker.translatesAutoresizingMaskIntoConstraints = false
    dueDatePicker.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    return dueDatePicker
  }()
  
  /// Creates an UITextField that represents the date user selects from the UIDatePickerView.
  let dueDateInput: UITextField = {
    let dueDateInput = UITextField()
    dueDateInput.translatesAutoresizingMaskIntoConstraints = false
    dueDateInput.placeholder = "MM-DD-YYYY"
    dueDateInput.borderStyle = UITextField.BorderStyle.roundedRect
    dueDateInput.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3882352941, blue: 0.5333333333, alpha: 1)
    dueDateInput.font = UIFont.systemFont(ofSize: 15)
    dueDateInput.textColor = .black
    return dueDateInput
  }()
  
  /// A property that represents a UIButton view named as "Back".
  let backButton = OutlineButton(title: "Back")
  
  /// A property that represents a UIButton view named as "Done".
  let doneButton = OutlineButton(title: "Done")
  
  /// A fileprivate property that represents a UIStackView containing two UIButton views.
  fileprivate lazy var optionsButtonsStack: UIStackView = {
    let buttonStack = UIStackView(arrangedSubviews: [backButton, doneButton])
    buttonStack.translatesAutoresizingMaskIntoConstraints = false
    buttonStack.axis = .horizontal
    buttonStack.distribution = .fillEqually
    buttonStack.alignment = .center
    buttonStack.spacing = 5
    return buttonStack
  }()
  
  /// A fileprivate property that represents a VStackView containing an UITextField view and a HStack view for buttons.
  fileprivate lazy var answerVStack: UIStackView = {
    let answerVStack = UIStackView(arrangedSubviews: [dueDateInput, optionsButtonsStack])
    answerVStack.translatesAutoresizingMaskIntoConstraints = false
    answerVStack.axis = .vertical
    answerVStack.distribution = .equalCentering
    answerVStack.alignment = .fill
    answerVStack.spacing = 2
    return answerVStack
  }()
  
  // MARK: - Initializers

  /// An override init method that builds up a view.
  /// - Parameter frame: Size of the view.
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    self.frame = UIScreen.main.bounds
    self.addSubview(container)
    
    setupLayout()
    createDatePicker()
  }
  
  /// A method that we use to set up every component for the layout on the screen.
  func setupLayout() {
    container.snp.makeConstraints { make in
      make.centerX.equalTo(self)
      make.centerY.equalTo(self)
      make.width.equalTo(self.snp.width).multipliedBy(0.7)
      make.height.equalTo(self.snp.height).multipliedBy(0.2)
    }
    
    container.addSubview(answerVStack)
    answerVStack.snp.makeConstraints { make in
      make.centerX.equalTo(container)
      make.centerY.equalTo(container)
      make.width.equalTo(container.snp.width).multipliedBy(0.8)
      make.height.equalTo(container.snp.height).multipliedBy(0.6)
    }
  }
  
  /// A method that displays a 'done' toolbar when users finish selecting the due date.
  func createToolbar() -> UIToolbar {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
    toolbar.setItems([doneBtn], animated: true)
    return toolbar
  }

  /// A method is called when users hit the done tool bar button.
  @objc func donePressed() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    self.dueDateInput.text = dateFormatter.string(from: dueDatePicker.date)
    self.endEditing(true)
  }
  
  /// A method that we use to set up a DatePicker view and a TextFieldView.
  func createDatePicker() {
    dueDatePicker.preferredDatePickerStyle = .wheels
    dueDatePicker.datePickerMode = .date
    dueDatePicker.minimumDate = NSCalendar.current.date(byAdding: .day, value: +0, to: Date())
    dueDateInput.inputView = dueDatePicker
    dueDateInput.inputAccessoryView = createToolbar()
    dueDateInput.textAlignment = .center
  }
  
  /// A required initializer used when an object needs to be initialized from data in an archive.
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
