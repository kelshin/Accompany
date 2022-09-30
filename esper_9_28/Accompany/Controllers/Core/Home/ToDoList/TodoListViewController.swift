//
//  TodoListViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-11.
//

import UIKit
import SnapKit

class TodoListViewController: UIViewController {
  
  let todoListTitleLabel = TitleLabel(title: nil, size: .medium, color: .red)
  
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.identifier)
    tableView.layer.cornerRadius = 20
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    return tableView
  }()
  
  var todos = [Todo]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
//    prepareLabel(label: self.todoListTitleLabel, string: "1", superScript: "st")
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    configureTableView()
        
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
  
  }
  
  private func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  @objc func didTapAdd() {
    let addnoteController = ToDoFormTableViewController()
    addnoteController.delegate = self
    navigationController?.pushViewController(addnoteController, animated: false)
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    view.addSubview(todoListTitleLabel)
    
    todoListTitleLabel.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    
    view.addSubview(tableView)
    tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    tableView.snp.makeConstraints { (make) -> Void in
      make.centerX.equalTo(view)
      make.centerY.equalTo(view)
      make.top.equalTo(todoListTitleLabel.snp.bottom).offset(10)
      make.width.equalTo(view.snp.width).multipliedBy(0.85)
      make.height.equalTo(view.snp.height).multipliedBy(0.4)
    }
  }
  
}

extension TodoListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier, for: indexPath) as! TodoCell
    let todo = todos[indexPath.row]
    
    // configure cell
    cell.update(with: todo)
    cell.isCompleteButton.isSelected = todo.isCompleted
    cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 55
     
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let addNoteTVC = ToDoFormTableViewController()
    addNoteTVC.todo = todos[indexPath.row]
    addNoteTVC.delegate = self
    navigationController?.pushViewController(addNoteTVC, animated: true)
    
  }
  
}

extension TodoListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
    // 1. update model
      todos.remove(at: indexPath.row)
    // 2. update view
      tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
      // 1. update model
      let todo = Todo(title: "")
      todos.insert(todo, at: 0)
      // 2. update view
      tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
  }
  
  func prepareLabel(label: UILabel, string: String, superScript: String){
    let font = UIFont(name: "SimpleBoy", size: 50)
    let fontSuper = UIFont(name: "SimpleBoy", size: 20)
    let fontExtension = label.text![label.text!.index(label.text!.startIndex,offsetBy: 3)..<label.text!.index(label.text!.endIndex, offsetBy: 0)]
    let attributedString = NSMutableAttributedString(string: string + superScript + fontExtension, attributes: [NSAttributedString.Key.font:font!])
    attributedString.setAttributes([NSAttributedString.Key.font:fontSuper!, NSAttributedString.Key.baselineOffset:10], range: NSRange(location: string.count, length: superScript.count))
    print()
    label.attributedText = attributedString
  }
}

extension TodoListViewController: ToDoFormTableViewControllerDelegate {
  
  func add(todo: Todo) {
    todos.append(todo)
    tableView.insertRows(at: [IndexPath(row: todos.count - 1, section: 0)], with: .automatic)
  }
  
  func edit(todo: Todo) {
    if let selectedIndexPath = tableView.indexPathForSelectedRow {
      todos[selectedIndexPath.row] = todo
      tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
    }
  }
  
}
