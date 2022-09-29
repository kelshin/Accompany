//
//  OurBabyViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit
import SnapKit

class OurBabyViewController: UIViewController {

  let babyTitle = TitleLabel(title: "Baby", size: .medium, color: .red)
  
  let nameTitleTextField: UITextField = {
    let nameTitleTextField = UITextField()
    nameTitleTextField.placeholder = "Type baby's name"
    nameTitleTextField.textAlignment = .center
    nameTitleTextField.textColor = .black
    nameTitleTextField.font = UIFont.boldSystemFont(ofSize: 18)
    nameTitleTextField.translatesAutoresizingMaskIntoConstraints = false
    return nameTitleTextField
  }()
  

  let babyIconTextField = UITextField()
  
  let icons = ["👶🏻", "👶🏼", "👶", "👶🏽", "👶🏿", "👧🏻", "👧🏼", "👧🏽", "👧🏾", "👧🏿"]
  
  var pickerView = UIPickerView()
  
  //TODO: Fetch due date from AnsPage the user choose and count left
  let leftNumberTitle: UILabel = {
    let leftNumberTitle = UILabel()
    leftNumberTitle.text = "xxx Left"
    leftNumberTitle.font = UIFont.systemFont(ofSize: 28, weight: .medium)
    leftNumberTitle.textColor = UIColor.black
    leftNumberTitle.translatesAutoresizingMaskIntoConstraints = false
    return leftNumberTitle
  }()
  
  let leftTitle: UILabel = {
    let leftTitle = UILabel()
    leftTitle.text = "Until the baby is born"
    leftTitle.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    leftTitle.textColor = UIColor.gray
    leftTitle.translatesAutoresizingMaskIntoConstraints = false
    return leftTitle
  }()


  let contentView: UIView = {
    let contentView = UIView()
    contentView.backgroundColor = .white
    contentView.layer.cornerRadius = 15
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    return contentView
  }()

  let babyImageView = ImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configPicker()
//    babyCalculator()
    
    babyIconTextField.inputView = pickerView
    babyIconTextField.textAlignment = .center
    babyIconTextField.text = "👶🏻"
    babyIconTextField.tintColor = UIColor.clear
    babyIconTextField.font = UIFont.boldSystemFont(ofSize: 35)
    babyImageView.image = UIImage(named: "baby-image")
    
    nameTitleTextField.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
    
    setupLayout()
    
    leftTitle.textAlignment = .center
  }
  
  override func viewWillAppear(_ animated: Bool) {
    nameTitleTextField.text = HomeViewController.currentUser.info?.babyName ?? ""
    babyCalculator()
  }
  
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    return false
  }
  
  func configPicker() {
    pickerView.delegate = self
    pickerView.dataSource = self
  }
  
  private func setupLayout() {
    view.addSubview(babyTitle)
    
    babyTitle.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.centerX.equalTo(view)
    }
    
    let iconNameVStack: UIStackView = {
      let iconNameVStack = UIStackView(arrangedSubviews: [babyIconTextField, nameTitleTextField])
      iconNameVStack.axis = .vertical
      iconNameVStack.distribution = .equalCentering
      iconNameVStack.alignment = .center
      iconNameVStack.spacing = 3
      iconNameVStack.translatesAutoresizingMaskIntoConstraints = false
      return iconNameVStack
    }()

    view.addSubview(iconNameVStack)

    iconNameVStack.snp.makeConstraints { make in
      make.top.equalTo(babyTitle.snp.bottom).offset(2)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.5)
      make.height.equalTo(view.snp.height).multipliedBy(0.1)
    }
   
    view.addSubview(contentView)
    
    contentView.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.top.equalTo(iconNameVStack.snp.bottom).offset(10)
      make.width.equalTo(view.snp.width).multipliedBy(0.73)
      make.height.equalTo(view.snp.height).multipliedBy(0.17)
    }
    
    let titleAndDueStack: UIStackView = {
      let stackView = UIStackView(arrangedSubviews: [leftNumberTitle, leftTitle])
      stackView.axis = .vertical
      stackView.distribution = .equalCentering
      stackView.alignment = .center
      stackView.spacing = 8
      stackView.translatesAutoresizingMaskIntoConstraints = false

      return stackView
    }()

    contentView.addSubview(titleAndDueStack)
    
    titleAndDueStack.snp.makeConstraints { make in
      make.centerX.equalTo(contentView.snp.centerX)
      make.centerY.equalTo(contentView.snp.centerY)
    }

    view.addSubview(babyImageView)

    babyImageView.snp.makeConstraints { make in
      make.top.equalTo(contentView.snp.bottom).offset(20)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.7)
      make.height.equalTo(view.snp.height).multipliedBy(0.28)
    }
    
  }
   
//  @objc func datePickerValueChanged(_ sender: UIDatePicker) {
//
//    let dateFormatter: DateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "dd/MM/yyyy"
//
//    let selectedDate: String = dateFormatter.string(from: sender.date)
//
//    let currentDateTime = Date()
//
//    let formatter = DateFormatter()
//    formatter.timeStyle = .none
//    formatter.dateStyle = .medium
//    formatter.dateFormat = "dd/MM/yyyy"
//    let todayDate: String = formatter.string(from: currentDateTime)
//
//    let dueDate = formatter.date(from: selectedDate)
//    let currentDate = formatter.date(from: todayDate)
//    let difference = (dueDate! - currentDate!)
//    let differenceDays = difference.asDays()
//
//    if differenceDays == 0 {
//      datePicker.isHidden = true
//      dueDateTitle.text = ""
//      leftTitle.text = ""
//      leftNumberTitle.text = ""
//
//      let button = OutlineButton(title: "🎉🎉🎉")
//      button.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
//      view.addSubview(button)
//
//      button.snp.makeConstraints { make in
//        make.centerX.equalTo(contentView)
//        make.top.equalTo(contentLabel.snp.bottom).offset(15)
//        make.bottom.equalTo(contentView.snp.bottom).offset(-5)
//        make.width.equalTo(view.snp.width).multipliedBy(0.33)
//      }
//
//    } else {
//      leftNumberTitle.text = "\(differenceDays) Days"
//    }
//
//  }
  
  func babyCalculator() {
    guard let userDueDate = HomeViewController.currentUser.info?.dueDate else {
      leftTitle.text = "due date not specified"
      leftNumberTitle.text = ""
      return
    }
    
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"

    let selectedDate: String = dateFormatter.string(from: userDueDate)

    let currentDateTime = Date()

    let formatter = DateFormatter()
    formatter.timeStyle = .none
    formatter.dateStyle = .medium
    formatter.dateFormat = "dd/MM/yyyy"
    let todayDate: String = formatter.string(from: currentDateTime)

    let dueDate = formatter.date(from: selectedDate)
    let currentDate = formatter.date(from: todayDate)
    let difference = (dueDate! - currentDate!)
    let differenceDays = difference.asDays()

    if differenceDays == 0 {
//      datePicker.isHidden = true
//      dueDateTitle.text = ""
      leftTitle.text = "Congratulations!"
      leftNumberTitle.text = "🎉🎉🎉"

//      let button = OutlineButton(title: "🎉🎉🎉")
//      button.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
//      view.addSubview(button)
//
//      button.snp.makeConstraints { make in
//        make.centerX.equalTo(contentView)
////        make.top.equalTo(contentLabel.snp.bottom).offset(15)
//        make.bottom.equalTo(contentView.snp.bottom).offset(-5)
//        make.width.equalTo(view.snp.width).multipliedBy(0.33)
//      }

    } else {
      leftNumberTitle.text = differenceDays > 1 ? "\(differenceDays) Days" : "\(differenceDays) Day"
    }
  }
  
  @objc func nameChanged(){
    HomeViewController.currentUser.info?.babyName = nameTitleTextField.text ?? ""
    HomeViewController().saveUserData()
  }
  
  @objc func btnTapped(_ sender: UIButton) {
    let alert = UIAlertController(title: "Congratulations!", message: "Your baby is coming today!", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "I'm ready!", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}

extension OurBabyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return icons.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return icons[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    babyIconTextField.text = icons[row]
    babyIconTextField.resignFirstResponder()
  }
  
}

extension Date {
  
  static func - (lhs: Date, rhs: Date) -> TimeInterval {
    return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
  }
  
}

extension TimeInterval {
  
  func asDays() -> Int {
    return Int(self / (60 * 60 * 24))
  }
  
}
