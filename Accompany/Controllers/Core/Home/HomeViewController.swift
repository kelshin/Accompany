//
//  HomeViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
  
  let accompanyTitleLabel = TitleLabel(title: "Accompany", size: .large, color: .red)
  let welcomeTitleLabel = TitleLabel(title: "Welcome back!", size: .mini, color: .black)

  let firstTrimesterButton = PrimaryButton(title: Trimester.firstTrimester.rawValue)
  let secondTrimesterButton = PrimaryButton(title: Trimester.secondTrimester.rawValue)
  let thirdTrimesterButton = PrimaryButton(title: Trimester.thirdTrimester.rawValue)
  let afterButton = SecondaryButton(title: Trimester.after.rawValue)
  
  let notifyTableView: UITableView = {
    let notifyTableView = UITableView(frame: .zero, style: .plain)
    notifyTableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.identifier)
    notifyTableView.register(TodoHeaderView.self, forHeaderFooterViewReuseIdentifier: TodoHeaderView.identifier)
    notifyTableView.isUserInteractionEnabled = true
    notifyTableView.layer.cornerRadius = 5
    notifyTableView.translatesAutoresizingMaskIntoConstraints = false
    
    return notifyTableView
  }()
  
  let bgCircleView = ImageView()
  
  
  static var currentUser = User()
  static var todoLists = [TodoList]()
  var currentTodos = [Todo]()
  var currentTrimester = String()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
 
    bgCircleView.image = UIImage(named: "grey-bg")
    
    // KELBIN
    print("I AM CURRENT USER")
    print(HomeViewController.currentUser)
    
//    createData()
    loadSavedData()
    fetchCurrentLists()
    
    if HomeViewController.currentUser.info?.dueDate == nil {
      print("Due date is nil")
      let getDueDate = PopupViewController()
      getDueDate.modalPresentationStyle = .fullScreen
      present(getDueDate, animated: false)
//      dismiss(animated: false, completion: nil)
//      navigationController?.pushViewController(PopupViewController, animated: <#T##Bool#>)
    }
    
    // TODO: fetch todoLists
    
    configureTableView()
    setupLayout()
    
    UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
           .textColor = UIColor.black
    UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
      .font = UIFont.systemFont(ofSize: 18)
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "Home Page", style: .plain, target: nil, action: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.isHidden = true
//    fetchUserDetails()
    fetchCurrentLists()
    notifyTableView.reloadData()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    navigationController?.navigationBar.isHidden = false
  }
  
  func saveTodoList() {
    let encoder = JSONEncoder()
    if let encoder = try? encoder.encode(HomeViewController.todoLists){
      let defaults = UserDefaults.standard
      defaults.set(encoder, forKey: "SavedTodos")
    }
  }
  
  func saveUserData() {
    let encoder = JSONEncoder()
    if let encoder = try? encoder.encode(HomeViewController.currentUser){
      let defaults = UserDefaults.standard
      defaults.set(encoder, forKey: "SavedUser")
    }
  }
  
  func loadSavedData(){
    let defaults = UserDefaults.standard
    let decoder = JSONDecoder()
    if let savedTodo = defaults.object(forKey: "SavedTodos") as? Data {
      if let loadedTodo = try? decoder.decode([TodoList].self, from: savedTodo){
        HomeViewController.todoLists = loadedTodo
      } else {
        print("Error loading previous list")
      }
    } else {
      HomeViewController.todoLists = TodoList.loadSampleTodoLists()
      saveTodoList()
    }
    if let savedUserData = defaults.object(forKey: "SavedUser") as? Data {
      if let loadedUserData = try? decoder.decode(User.self, from: savedUserData){
        HomeViewController.currentUser = loadedUserData
      } else {
        print("Error loading user data")
      }
    } else {
        HomeViewController.currentUser.info = Info.loadSampleInfo()
    }
    print(HomeViewController.currentUser)
  }
  
//  private func fetchUserDetails() {
//    if HomeViewController.currentUser.info == nil {
//      HomeViewController.currentUser.info = Info.loadSampleInfo()
//    }
//    print(HomeViewController.currentUser.info)
//  }
  
//  private func fetchTodoLists() {
//    // fetch todolists
//    loadSavedData()
//  }
  
  private func fetchCurrentLists() {
    // decide current trimester
    let currentTrimester = getCurrentTrimester()
    
    // assign current todos
    currentTodos = TodoList.getTodos(of: currentTrimester, from: HomeViewController.todoLists, status: .notDone) ?? [Todo]()
  }
  
  private func getCurrentTrimester() -> Trimester {
    // due date got from the AnsVC
//    let dueDate = Date.init("2022-12-31")
    
//    let dueDate = HomeViewController.currentUser.info?.dueDate ?? {
//      let due = Date()
//      var dateComponent = DateComponents()
//      dateComponent.day = 365
//      let futureDate = Calendar.current.date(byAdding: dateComponent, to: due)
//
//      return futureDate
//    }()
    
    guard let dueDate = HomeViewController.currentUser.info?.dueDate else {
      currentTrimester = Trimester.firstTrimester.rawValue
      return .firstTrimester
    }
    print(Date().description(with: .current))
    // TODO: get date of pregnancy
    
    // calculate which trimester
    // TODO: change Date() to date of pregnancy
    let dateDifference = (dueDate - Date()).asDays()
    
    switch Double(dateDifference) / 7.0 {
    case Double(Int.min)..<14:
      currentTrimester = Trimester.after.rawValue
      return .after
    case 14..<29:
      currentTrimester = Trimester.thirdTrimester.rawValue
      return .thirdTrimester
    case 29..<41:
      currentTrimester = Trimester.secondTrimester.rawValue
      return .secondTrimester
    default:
      currentTrimester = Trimester.firstTrimester.rawValue
      return .firstTrimester
    }
  }
  
  private func configureTableView() {
    notifyTableView.delegate = self
    notifyTableView.dataSource = self
    notifyTableView.sectionHeaderTopPadding = .zero
  }
  
  private func setupLayout() {
   
    view.addSubview(accompanyTitleLabel)
    
    accompanyTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
      make.centerX.equalTo(view)
    }
    
    view.addSubview(welcomeTitleLabel)
    
    welcomeTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(accompanyTitleLabel.snp.bottom).offset(3)
      make.centerX.equalTo(view)
    }

    view.addSubview(notifyTableView)
       
    notifyTableView.backgroundColor = .white
     
    notifyTableView.snp.makeConstraints { (make) -> Void in
      make.centerX.equalTo(view)
      make.top.equalTo(welcomeTitleLabel.snp.bottom).offset(20)
      make.width.equalTo(view.snp.width).multipliedBy(0.84)
      make.height.equalTo(view.snp.width).multipliedBy(0.5)
    }
    
    view.addSubview(bgCircleView)

    bgCircleView.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.top.equalTo(notifyTableView.snp.bottom).offset(20)
      make.left.equalTo(view.safeAreaLayoutGuide)
      make.right.equalTo(view.safeAreaLayoutGuide)
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(5)
    }
    
    let buttons = [firstTrimesterButton, secondTrimesterButton, thirdTrimesterButton, afterButton]
    buttons.forEach { $0.addTarget(self, action: #selector(goToTodoList(_:)), for: .touchUpInside) }
    
    let stackView = UIStackView(arrangedSubviews: buttons)
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 15
          
    view.addSubview(stackView)
    
    stackView.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.top.equalTo(bgCircleView.snp.top).offset(45)
      make.width.equalTo(view.snp.width).multipliedBy(0.45)
    }
  }
   
  @objc func goToTodoList(_ button: UIButton) {
    let todoListVC = TodoListViewController()
    
    switch button {
    case firstTrimesterButton:
      todoListVC.todoListTitleLabel.text = Trimester.firstTrimester.rawValue
      todoListVC.currentTrimester = Trimester.firstTrimester.rawValue
      todoListVC.todos = TodoList.getTodos(of: .firstTrimester, from: HomeViewController.todoLists, status: .all) ?? [Todo]()
    case secondTrimesterButton:
      todoListVC.todoListTitleLabel.text = Trimester.secondTrimester.rawValue
      todoListVC.currentTrimester = Trimester.secondTrimester.rawValue
      todoListVC.todos = TodoList.getTodos(of: .secondTrimester, from: HomeViewController.todoLists, status: .all) ?? [Todo]()
    case thirdTrimesterButton:
      todoListVC.todoListTitleLabel.text = Trimester.thirdTrimester.rawValue
      todoListVC.currentTrimester = Trimester.thirdTrimester.rawValue
      todoListVC.todos = TodoList.getTodos(of: .thirdTrimester, from: HomeViewController.todoLists, status: .all) ?? [Todo]()
    case afterButton:
      todoListVC.todoListTitleLabel.text = Trimester.after.rawValue
      todoListVC.currentTrimester = Trimester.after.rawValue
      todoListVC.todos = TodoList.getTodos(of: .after, from: HomeViewController.todoLists, status: .all) ?? [Todo]()
    default:
      return
    }
    
    navigationController?.pushViewController(todoListVC, animated: true)
  }
  
}

extension HomeViewController: UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return tableView.dequeueReusableHeaderFooterView(withIdentifier: TodoHeaderView.identifier) as? TodoHeaderView
  }
    
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 30
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentTodos.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 58
  }
}
  
extension HomeViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier, for: indexPath) as! TodoCell
    let toDo = currentTodos[indexPath.row]
    cell.delegate = self
    cell.update(with: toDo)
    cell.backgroundColor = .white
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let addNoteTVC = ToDoFormTableViewController()
    addNoteTVC.todo = currentTodos[indexPath.row]
    print(currentTodos[indexPath.row].id)
    addNoteTVC.delegate = self
    navigationController?.pushViewController(addNoteTVC, animated: true)
  }
  
//  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//    if editingStyle == .delete {
//    // 1. update model
//      currentTodos.remove(at: indexPath.row)
//    // 2. update view
//      tableView.deleteRows(at: [indexPath], with: .fade)
//    }
//  }
}


extension HomeViewController: TodoCellDelegate {
  
  func isCompleteButtonTapped(sender: TodoCell) {
    if let indexPath = notifyTableView.indexPath(for: sender) {
      var todo = currentTodos[indexPath.row]
      todo.isCompleted.toggle()
      
      // update model
      currentTodos[indexPath.row].isCompleted.toggle()

      if let trimesterIndex =  HomeViewController.todoLists.firstIndex(where: { $0.trimester.rawValue == currentTrimester }){
        if let todoIndex = HomeViewController.todoLists[trimesterIndex].todos?.firstIndex(where: { $0.id == todo.id }) {
          HomeViewController.todoLists[trimesterIndex].todos?[todoIndex] = todo
        }
      }
      
      currentTodos.remove(at: indexPath.row)
      notifyTableView.reloadData()
      
      // TODO: save changes to database
      saveTodoList()
    }
  }
}


extension HomeViewController: ToDoFormTableViewControllerDelegate {

  func add(todo: Todo) {
  }

  func edit(todo: Todo) {
    if let trimesterIndex =  HomeViewController.todoLists.firstIndex(where: { $0.trimester.rawValue == currentTrimester }){
      if let todoIndex = HomeViewController.todoLists[trimesterIndex].todos?.firstIndex(where: { $0.id == todo.id }) {
        HomeViewController.todoLists[trimesterIndex].todos?[todoIndex] = todo
      }
    }
    saveTodoList()
  }
}

extension Date {
  
  init(_ dateString: String) {
    let dateStringFormatter = DateFormatter()
    dateStringFormatter.dateFormat = "yyyy-mm-dd"
    dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
    
    let date = dateStringFormatter.date(from: dateString)!
    self.init(timeInterval:0, since:date)
  }
}

