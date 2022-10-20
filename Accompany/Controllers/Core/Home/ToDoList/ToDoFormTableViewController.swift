//
//  SemesterDetailsTableViewController.swift
//  Accompany
//
//  Created by Kelbin David on 2022-02-10.
//

import UIKit
import SnapKit

protocol ToDoFormTableViewControllerDelegate {
  func add(todo: Todo)
  func edit(todo: Todo)
}

class ToDoFormTableViewController: UITableViewController {
  
  var toDoBasicInfoCell = ToDoBasicInfoCell()
  var toDoNotesCell = ToDoNotesCell()
  
  var saveBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
  
  var todo: Todo?
  var delegate: ToDoFormTableViewControllerDelegate?
  let basicInfoCellIndexPath = IndexPath(row: 0, section: 0)
  let notesCellIndexPath = IndexPath(row: 0, section: 1)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    configurateNavigationItem()
    
    tableView.isUserInteractionEnabled = true
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(textViewDidChange), name: UITextView.textDidChangeNotification, object: nil)
    updateSaveButtonState()
  }
  
  private func configurateNavigationItem() {
    self.navigationItem.rightBarButtonItem = saveBarButton
    if todo != nil {
      navigationItem.title = "Edit To Do"
    } else {
      navigationItem.title = "Add To Do"
    }
  }
  
  @objc func saveButtonTapped() {
    let id = todo?.id != nil ? todo?.id : UUID()
    let isComplete = toDoBasicInfoCell.isCompleteButton.isSelected
    let todoTitle = toDoBasicInfoCell.toDoTextView.text!
    let note = toDoNotesCell.noteTextView.text ?? ""
    let newTodo = Todo(id: id!, title: todoTitle, isCompleted: isComplete, note: note)
    
    if todo != nil {
      delegate?.edit(todo: newTodo)
    } else {
      delegate?.add(todo: newTodo)
    }
    
    self.navigationController?.popViewController(animated: true)
  }

  func updateSaveButtonState() {
    let title = toDoBasicInfoCell.toDoTextView.text ?? ""
    saveBarButton.isEnabled = !title.isEmpty
  }
  
  @objc func isCompleteButtonTapped(sender: UIButton) {
    updateSaveButtonState()
    sender.isSelected.toggle()
    toDoBasicInfoCell.toDoTextView.becomeFirstResponder()
  }
  
  @objc func toDoTitleTextFieldEditingChanged(sender: UITextField) {
    updateSaveButtonState()
  }
  
  @objc func textViewDidChange(_ notif: NSNotification) {
    guard notif.object is UITextView else { return }
    updateSaveButtonState()
  }
  
  // MARK: - Table view data source

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return "BASIC INFORMATION"
    case 1:
      return "NOTES"
    default:
      return ""
    }
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      toDoBasicInfoCell.isCompleteButton.addTarget(self, action: #selector(isCompleteButtonTapped), for: .touchUpInside)
      toDoBasicInfoCell.isCompleteButton.isSelected = todo?.isCompleted == nil ? false : todo!.isCompleted
      //toDoBasicInfoCell.toDoTextField.addTarget(self, action: #selector(toDoTitleTextFieldEditingChanged), for: .editingChanged)
      toDoBasicInfoCell.toDoTextView.text = todo?.title
      return toDoBasicInfoCell
    } else {
      toDoNotesCell.contentView.isUserInteractionEnabled = false
      toDoNotesCell.noteTextView.text = todo?.note
      
      return toDoNotesCell
    }
  
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath {
    case basicInfoCellIndexPath:
      return 60
    case notesCellIndexPath:
      return 300
    default:
      return UITableView.automaticDimension
    }
  }
  
  override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    guard let header = view as? UITableViewHeaderFooterView else { return }
     header.textLabel?.frame = header.bounds
    header.textLabel?.snp.makeConstraints{ make in
      make.left.equalTo(15)
    }
     header.textLabel?.textAlignment = .left
  }
}
