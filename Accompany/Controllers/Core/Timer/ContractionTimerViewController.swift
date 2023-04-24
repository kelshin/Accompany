//
//  ContractionTimerViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-15.
//

import UIKit
import SnapKit

class ContractionTimerViewController: UIViewController {
  
  let titleLabel = TitleLabel(title: "Contraction Timer", size: .medium, color: .red)
 
  var userConstractionRecords : [ContractionTimerModel]?
  var newRecord: ContractionTimerModel?
  var timerValue : String?
  var todaysRecord = [[String]]()
  
  var currentRecordingTitle: String?
  var currentRecordingTime: String?
  
  var startTime: Date?
  var stopTime: Date?
  
  let userDefaults = UserDefaults.standard
  
  var START_TIME_KEY = "startTime"
  var STOP_TIME_KEY = "stopTime"
  var COUNTING_KEY = "countingKey"
  var scheduledTimer: Timer!
  
  
  var inRecordsTab: Bool = false {
    didSet {
      recordList.isHidden = !inRecordsTab
      contractionAndRecordTab.setTitle(inRecordsTab ? "Contraction" : "Records", for: .normal)
      titleLabel.text = inRecordsTab ? "Records" : "Contraction Timer"
    }
  }
  
  var timerCounting: Bool = false {
    didSet {
      stopButton.isEnabled = timerCounting
    }
  }
  
  var isContracting: Bool = false {
    didSet {
      if timerCounting {
        currentRecordingTitle = startButton.currentTitle
      if isContracting {
        startButton.setTitle("Rest", for: .normal)
        startButton.backgroundColor = #colorLiteral(red: 0.3890488148, green: 0.8415637016, blue: 0.7544795871, alpha: 1)
      } else {
        startButton.setTitle("Start", for: .normal)
        startButton.backgroundColor = #colorLiteral(red: 0.9845016599, green: 0.3794513941, blue: 0.5343101621, alpha: 1)
      }
      }
    }
  }
  
  var contractionAndRecordTab : UIButton = {
    let button = UIButton()
    button.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3882352941, blue: 0.5333333333, alpha: 1)
    button.setTitle("Records", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(contractionAndRecordTabTapped), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()
  
  var buttonsStackView : UIStackView = {
    let buttonsStackView = UIStackView()
    buttonsStackView.axis = .horizontal
    buttonsStackView.distribution = .fillEqually
    buttonsStackView.alignment = .center
    buttonsStackView.spacing = 10
    buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
    
    return buttonsStackView
  }()
  
  let timerLabelStackView : UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .equalSpacing
    stackView.axis = .horizontal
    stackView.alignment = .top
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    return stackView
  }()
  
  var minutesLabel : UILabel = {
    let label = UILabel()
    label.text = "00"
    label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    label.font = .systemFont(ofSize: 60)
    //label.font = UIFont(name: "Didot", size: 60)
    label.translatesAutoresizingMaskIntoConstraints = false

    return label
  }()
  
  var minutesSignLabel : UILabel = {
    let label = UILabel()
    label.text = "M"
    label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    label.font = .systemFont(ofSize: 20)
    //label.font = UIFont(name: "Didot", size: 20)
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  var secondsLabel : UILabel = {
    let label = UILabel()
    label.text = "00"
    label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    label.font = .systemFont(ofSize: 60)
    //label.font = UIFont(name: "Didot", size: 60)
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  var secondsSignLabel : UILabel = {
    let label = UILabel()
    label.text = "S"
    label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    label.font = .systemFont(ofSize: 20)
    //label.font = UIFont(name: "Didot", size: 20)
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  var startButton = PrimaryButton(title: "Start")
  var stopButton = OutlineButton(title: "Save record")
  
  var timerAndButtonStackView : UIStackView = {
    let timerAndButtonStackView = UIStackView()
    timerAndButtonStackView.axis = .vertical
    timerAndButtonStackView.distribution = .equalSpacing
    timerAndButtonStackView.alignment = .center
    timerAndButtonStackView.spacing = 30
    timerAndButtonStackView.translatesAutoresizingMaskIntoConstraints = false
    
    return timerAndButtonStackView
  }()
  
  var currentRecordList : UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    return tableView
  }()
  
  var recordList = UITableView()
  
  let headerLabel : UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.textAlignment = .center
    label.text = "Length"
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    label.backgroundColor = #colorLiteral(red: 0.5490196078, green: 0.4588235294, blue: 0.968627451, alpha: 1)
    
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    addSubview()
    snpConstraints()
    tableViewsSetup()
    
    startTime = userDefaults.object(forKey: START_TIME_KEY) as? Date
    stopTime = userDefaults.object(forKey: STOP_TIME_KEY) as? Date
    timerCounting = userDefaults.bool(forKey: COUNTING_KEY)
    
    stopButton.isEnabled = timerCounting
    
    startButton.addTarget(self, action: #selector(startRestTimer), for: .touchUpInside)
    stopButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
    
    if timerCounting {
      startTimer()
    } else {
      stopTimer()
      if let start = startTime {
        if let stop = stopTime {
          let time = calcRestartTime(start: start, stop: stop)
          let diff = Date().timeIntervalSince(time)
          setTimeLabel(Int(diff))
        }
      }
    }
    
    userConstractionRecords = HomeViewController.currentUser.contractionRecord
//    userConstractionRecords = [
//      Contractions(contractionDate: Date(), contractionRecord: [Detail(state: "Constracting", length: "00:04"),Detail(state: "Rest", length: "00:04")]),
//      Contractions(contractionDate: Date(), contractionRecord: [Detail(state: "Constracting", length: "00:06"),Detail(state: "Rest", length: "00:02")])]
//    newRecord =
//      Contractions(contractionDate: Date(), contractionRecord: [Detail(state: "Constracting", length: "00:04"),Detail(state: "Rest", length: "00:07")])
    
  }
  
  func addSubview(){
    buttonsStackView.addArrangedSubview(startButton)
    buttonsStackView.addArrangedSubview(stopButton)
 
    timerLabelStackView.addArrangedSubview(minutesLabel)
    timerLabelStackView.addArrangedSubview(minutesSignLabel)
    timerLabelStackView.addArrangedSubview(secondsLabel)
    timerLabelStackView.addArrangedSubview(secondsSignLabel)
 
    timerAndButtonStackView.addArrangedSubview(timerLabelStackView)
    timerAndButtonStackView.addArrangedSubview(buttonsStackView)
    
    view.addSubview(titleLabel)
    view.addSubview(timerAndButtonStackView)
    view.addSubview(headerLabel)
    view.addSubview(currentRecordList)
    view.addSubview(recordList)
    view.addSubview(contractionAndRecordTab)
  }
  
  private func snpConstraints() {
    
    titleLabel.snp.makeConstraints { make in
      make.width.equalTo(view.snp.width)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
    }
    
    timerAndButtonStackView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom)
      make.width.equalTo(view.snp.width)
    }
    
    buttonsStackView.snp.makeConstraints { make in
      make.left.equalTo(timerAndButtonStackView.snp.left).offset(50)
      make.right.equalTo(timerAndButtonStackView.snp.right).offset(-50)
    }
    
    headerLabel.snp.makeConstraints { make in
      make.top.equalTo(timerAndButtonStackView.snp.bottom).offset(30)
      make.centerX.equalTo(view.snp.centerX)
      make.width.equalTo(view.snp.width)
      make.height.equalTo(50)
    }
    
    currentRecordList.snp.makeConstraints { make in
      make.top.equalTo(headerLabel.snp.bottom)
      make.width.equalTo(view.snp.width)
      make.bottom.equalTo(contractionAndRecordTab.snp.top)
    }
    
    recordList.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom)
      make.left.equalTo(view.snp.left)
      make.right.equalTo(view.snp.right)
      make.bottom.equalTo(contractionAndRecordTab.snp.top)
    }
    
    contractionAndRecordTab.snp.makeConstraints { make in
      make.centerX.equalTo(view.snp.centerX)
      make.width.equalTo(view.snp.width)
      make.height.equalTo(50)
      make.bottom.equalTo(-15 + -(self.tabBarController!.tabBar.frame.size.height))
    }
    
    minutesSignLabel.snp.makeConstraints { make in
      make.height.equalTo(40)
    }
    
    secondsSignLabel.snp.makeConstraints { make in
      make.height.equalTo(40)
    }
    
 
  }
  
  func tableViewsSetup() {
    recordList.delegate = self
    recordList.dataSource = self
    recordList.register(UITableViewCell.self, forCellReuseIdentifier: "savedRecordCell")
    currentRecordList.register(UITableViewCell.self, forCellReuseIdentifier: "currentRecordCell")
    currentRecordList.delegate = self
    currentRecordList.dataSource = self
    recordList.isHidden = true
  }

  func setStartTime(date: Date?){
    startTime = date
    userDefaults.set(startTime, forKey: START_TIME_KEY)
  }
  func setStopTime(date: Date?){
    stopTime = date
    userDefaults.set(stopTime, forKey: STOP_TIME_KEY)
  }
  func setTimerCounting(_ val: Bool){
    timerCounting = val
    userDefaults.set(timerCounting, forKey: COUNTING_KEY)
  }
  
  @objc func startRestTimer() {
    if timerCounting {
      recordData()
      isContracting.toggle()
    } else {
      if let stop = stopTime {
        let restartTime = calcRestartTime(start: startTime!, stop: stop)
        setStopTime(date: nil)
        setStartTime(date: restartTime)
      } else {
        setStartTime(date: Date())
      }
      startTimer()
    }
  }
    
  func calcRestartTime(start: Date, stop: Date) -> Date {
    let diff = start.timeIntervalSince(stop)
      
    return Date().addingTimeInterval(diff)
  }
  
  func startTimer() {
    scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
    setTimerCounting(true)
    newRecord = ContractionTimerModel(contractionDate: Date(), contractionRecord: [])
    currentRecordList.reloadData()
    isContracting.toggle()
  }
  
  @objc func refreshValue(){
    if let start = startTime {
      let diff = Date().timeIntervalSince(start)
      setTimeLabel(Int(diff))
    } else {
      stopTimer()
      setTimeLabel(0)
    }
  }
  
  func setTimeLabel(_ val: Int){
    let time = secondsToMinutesSeconds(val)
    minutesLabel.text = String(format: "%02d", time.0)
    secondsLabel.text = String(format: "%02d", time.1)
    timerValue = makeTimeString(min: time.0, sec: time.1)
  }
  
  func secondsToMinutesSeconds(_ ms: Int) -> (Int, Int){
    let min = (ms % 3600) / 60
    let sec = (ms % 3600) % 60
    
    return (min, sec)
  }
  
  func makeTimeString(min: Int, sec: Int) -> String {
    var timeString  = ""
    timeString += String(format: "%02d", min)
    timeString += ":"
    timeString += String(format: "%02d", sec)
    return timeString
  
  }
  
  func recordData(){
    if timerCounting {
      newRecord?.contractionRecord?.append(Detail(state: currentRecordingTitle! == "Start" ? "Contracting" : currentRecordingTitle!, length: timerValue))
      currentRecordList.reloadData()
    } else {
      newRecord = nil
      newRecord = ContractionTimerModel(contractionDate: Date(), contractionRecord: [])
    }
    setStartTime(date: Date())
    minutesLabel.text = "00"
    secondsLabel.text = "00"
  }
  
  func saveRecord() {
    print("saving record")
//    print(newRecord)
    if HomeViewController.currentUser.contractionRecord != nil {
      HomeViewController.currentUser.contractionRecord?.insert(newRecord!, at: 0)
    } else {
      HomeViewController.currentUser.contractionRecord = [newRecord!]
    }
    HomeViewController().saveUserData()
    print(HomeViewController.currentUser)
  }
  
  @objc func contractionAndRecordTabTapped() {
    inRecordsTab.toggle()
  }
  
  @objc func stopTimer(){
    if newRecord != nil {
      newRecord?.contractionRecord?.append(Detail(state: currentRecordingTitle! == "Start" ? "Contracting" : currentRecordingTitle!, length: timerValue))
      saveRecord()
      currentRecordList.reloadData()
      if userConstractionRecords != nil {
        userConstractionRecords?.insert(newRecord!, at: 0)
      } else {
        userConstractionRecords = [newRecord!]
      }
      recordList.reloadData()
    }
    if scheduledTimer != nil {
      scheduledTimer.invalidate()
    }
    resetTimer()
    setTimerCounting(false)
    isContracting = false
    startButton.setTitle("Start", for: .normal)
    startButton.backgroundColor = #colorLiteral(red: 0.9845016599, green: 0.3794513941, blue: 0.5343101621, alpha: 1)
  }

  @objc func resetTimer(){
    setStopTime(date: nil)
    setStartTime(date: nil)
    minutesLabel.text = "00"
    secondsLabel.text = "00"
  }
}

extension ContractionTimerViewController: UITableViewDelegate, UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    switch tableView {
    case recordList:
      return userConstractionRecords?.count ?? 0
    default:
      return 1
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
    
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch tableView {
    case recordList:
      let currentCell = tableView.cellForRow(at: IndexPath(row: 0, section: indexPath.section))
      let currentCellisSelected = currentCell?.isSelected ?? false
      if currentCellisSelected && indexPath.row != 0 {
        return tableView.rowHeight
      } else if !currentCellisSelected && indexPath.row != 0 {
        return 0
      }
      return tableView.rowHeight
    default:
      return tableView.rowHeight
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch tableView {
    case recordList:
      if let rows = userConstractionRecords?[section].contractionRecord?.count {
        return rows + 2
      }
      fallthrough
    case currentRecordList:
      return newRecord?.contractionRecord?.count ?? 0
    default:
      return 0
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch tableView {
    case recordList:
      let cell =  UITableViewCell(style: .value1, reuseIdentifier: "savedRecordCell")
      let numberOfContraction = userConstractionRecords?[indexPath.section].contractionRecord?.count ?? 0
      print("\(indexPath.row) and \(numberOfContraction)")
      if indexPath.row == 0 {
          let dateformatter = DateFormatter()
          dateformatter.dateFormat = "E, d MMM yyyy - HH:mm:ss"
          cell.textLabel?.text = dateformatter.string(from: userConstractionRecords![indexPath.section].contractionDate!)
      } else if indexPath.row == numberOfContraction + 1 {
        cell.textLabel?.text = "Total number of contraction: \(Array(1...numberOfContraction).reduce(0) {$0 + ($1 % 2)})"
        cell.textLabel?.font = .boldSystemFont(ofSize: 16.0)
      } else {
          let detailrows = indexPath.row - 1
          cell.textLabel?.text = userConstractionRecords?[indexPath.section].contractionRecord?[detailrows].state
          cell.detailTextLabel?.text = String((userConstractionRecords?[indexPath.section].contractionRecord?[detailrows].length)!)
          cell.backgroundColor = (indexPath.row % 2) == 0 ? .white : #colorLiteral(red: 0.9490194917, green: 0.9490197301, blue: 0.9533253312, alpha: 1)
        }
      cell.clipsToBounds = true
      return cell
    default:
      let cell =  UITableViewCell(style: .value1, reuseIdentifier: "currentRecordCell")
      cell.textLabel?.text = newRecord?.contractionRecord?[indexPath.row].state
      cell.detailTextLabel?.text = String((newRecord?.contractionRecord?[indexPath.row].length)!)
      cell.clipsToBounds = false
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return indexPath.row > 0 ? false : true
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //print(userConstractionRecords!)
//    let currentCell = tableView.cellForRow(at: indexPath)
////    if currentCell!.isSelected {
////      currentCell?.isSelected = false
////      }
    guard tableView == recordList else { return }
    tableView.beginUpdates()
    tableView.endUpdates()
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      userConstractionRecords?.remove(at: indexPath.section)
      print(indexPath.section)
      print("delete here")
//      print(HomeViewController.currentUser.contractionRecord?.count)
      HomeViewController.currentUser.contractionRecord?.remove(at: indexPath.section)
//      print(HomeViewController.currentUser.contractionRecord?.count)
//      saveRecord()
      tableView.reloadData()
    }
  }
}
