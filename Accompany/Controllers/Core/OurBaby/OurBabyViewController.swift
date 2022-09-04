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
  
  //TODO: Fetch baby's name from DB
  let nameTitle = TitleLabel(title: "Baby's name", size: .small, color: .black)
  
  let babyIconTextField = UITextField()
  
  let icons = ["👶🏻", "👶🏼", "👶", "👶🏽", "👶🏿"]
  
  var pickerView = UIPickerView()
  
  let leftNumberTitle = TitleLabel(title: "", size: .mini, color: .black)
  let leftTitle = TitleLabel(title: "Days left", size: .mini, color: .grey)
  
  //TODO: Fetch due date from DB
  var dueDateTitle = TitleLabel(title: "Due Date", size: .mini, color: .grey)
  

  let contentView: UIView = {
    let contentView = UIView()
    contentView.backgroundColor = .white
    contentView.layer.cornerRadius = 15
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    return contentView
  }()
  
  let contentLabel: UILabel = {
    let contentLabel = UILabel()
    contentLabel.text = "Hello🖐🏻 I'm your little baby.\n So excited to see this world!\n Can't wait to see everyone❤️"
    contentLabel.textColor = .gray
    contentLabel.textAlignment = .center
    contentLabel.font = UIFont.systemFont(ofSize: 17)
    contentLabel.numberOfLines = 0
    contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    contentLabel.translatesAutoresizingMaskIntoConstraints = false
    
    return contentLabel
  }()
  
  let lineSeperator: UIView = {
    let line = UIView()
    line.translatesAutoresizingMaskIntoConstraints = false
    line.backgroundColor = #colorLiteral(red: 0.7442027926, green: 0.6809862256, blue: 0.9618487954, alpha: 1)
    
    line.snp.makeConstraints { make in
      make.height.equalTo(2)
    }
    
    return line
  }()

  let babyImageView = ImageView()
  
  let datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.timeZone = NSTimeZone.local
    datePicker.backgroundColor = .white
    datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    
    return datePicker
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configPicker()
    
    babyIconTextField.inputView = pickerView
    babyIconTextField.backgroundColor = .white
    babyIconTextField.layer.cornerRadius = 15
    babyIconTextField.textAlignment = .center
    babyIconTextField.text = "👶🏻"
  
    babyImageView.image = UIImage(named: "baby-image")
    
    datePicker.datePickerMode = .date
    datePicker.minimumDate = NSCalendar.current.date(byAdding: .day, value: +1, to: Date())
   
    setupLayout()
    
    leftTitle.textAlignment = .left
  }
  
  func configPicker() {
    pickerView.delegate = self
    pickerView.dataSource = self
  }
  
  private func setupLayout() {
    view.addSubview(babyTitle)
    
    babyTitle.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    
    view.addSubview(babyIconTextField)

    babyIconTextField.snp.makeConstraints { make in
      make.top.equalTo(babyTitle.snp.bottom)
      make.centerX.equalTo(view)
      make.width.equalTo(30)
      make.height.equalTo(30)
    }
    
    let stackView: UIStackView = {
      let stackView = UIStackView(arrangedSubviews: [nameTitle, contentView])
      stackView.axis = .vertical
      stackView.distribution = .fill
      stackView.alignment = .fill
      stackView.spacing = 10
      stackView.translatesAutoresizingMaskIntoConstraints = false

      return stackView
    }()

    view.addSubview(stackView)

    stackView.snp.makeConstraints { make in
      make.top.equalTo(babyIconTextField.snp.bottom).offset(15)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.9)
      make.height.equalTo(stackView.snp.width).multipliedBy(0.7)
    }
    
    let titleAndDueStack: UIStackView = {
      let stackView = UIStackView(arrangedSubviews: [leftNumberTitle, datePicker])
      stackView.axis = .horizontal
      stackView.distribution = .fill
      stackView.alignment = .center
      stackView.spacing = 5
      stackView.translatesAutoresizingMaskIntoConstraints = false
      
      return stackView
    }()
    
    let titlesStack: UIStackView = {
      let stackView = UIStackView(arrangedSubviews: [leftTitle, dueDateTitle])
      stackView.axis = .horizontal
      stackView.distribution = .fill
      stackView.alignment = .fill
      stackView.spacing = 5
      stackView.translatesAutoresizingMaskIntoConstraints = false
      
      return stackView
    }()

    let showTitleDateStack: UIStackView = {
      let stackView = UIStackView(arrangedSubviews: [contentLabel, lineSeperator, titleAndDueStack, titlesStack])
      stackView.axis = .vertical
      stackView.distribution = .fill
      stackView.alignment = .fill
      stackView.spacing = 15
      stackView.translatesAutoresizingMaskIntoConstraints = false

      return stackView
    }()

    contentView.addSubview(showTitleDateStack)

    showTitleDateStack.snp.makeConstraints { make in
      make.top.equalTo(contentView.snp.top).offset(10)
      make.centerX.equalTo(contentView)
      make.bottom.equalTo(contentView.snp.bottom).offset(-15)
    }
    
    view.addSubview(babyImageView)
 
    babyImageView.snp.makeConstraints { make in
      make.top.equalTo(contentView.snp.bottom).offset(5)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.7)
      make.height.equalTo(view.snp.height).multipliedBy(0.28)
    }
    
  }
   
  @objc func datePickerValueChanged(_ sender: UIDatePicker) {

    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"

    let selectedDate: String = dateFormatter.string(from: sender.date)

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
      datePicker.isHidden = true
      dueDateTitle.text = ""
      leftTitle.text = ""
      leftNumberTitle.text = ""
      
      let button = OutlineButton(title: "🎉🎉🎉")
      button.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
      view.addSubview(button)
      
      button.snp.makeConstraints { make in
        make.centerX.equalTo(contentView)
        make.top.equalTo(lineSeperator.snp.bottom).offset(15)
        make.bottom.equalTo(contentView.snp.bottom).offset(-5)
        make.width.equalTo(view.snp.width).multipliedBy(0.33)
      }
      
    } else {
      leftNumberTitle.text = "\(differenceDays) Days"
    }
    
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
