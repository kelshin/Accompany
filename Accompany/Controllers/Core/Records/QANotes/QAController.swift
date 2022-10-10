//
//  DoctorNoteViewController.swift
//  Accompany
//
//  Created by Kelbin David on 2022-02-17.
//
import UIKit
import SnapKit

class QAController: UIViewController, UIScrollViewDelegate {

  var noteContent : String?
  
  let titleLabel = TitleLabel(title: "Take Notes", size: .medium)
  
  let rightBarButton : UIButton = {
    let button = UIButton()
    button.setTitle("Edit", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()
  
  let DrNoteTextView : UITextView = {
    let textView = UITextView()
    textView.isUserInteractionEnabled = false
    textView.font = .boldSystemFont(ofSize: 18)
    textView.translatesAutoresizingMaskIntoConstraints = false
    
    return textView
  }()
  
  let noteViewContainer : UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 15
    return view
  }()
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    if isEditing {
      DrNoteTextView.text = DrNoteTextView.text == "Tap edit to add notes here" ? "" : DrNoteTextView.text
      DrNoteTextView.becomeFirstResponder()
      
    } else {
      noteContent = DrNoteTextView.text == "" ? nil : DrNoteTextView.text
      HomeViewController.currentUser.note = noteContent
      HomeViewController().saveUserData()
    }
    DrNoteTextView.isUserInteractionEnabled.toggle()
  }
  
  let scrollView : UIScrollView = {
    let scrollView = UIScrollView()
    return scrollView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    addSubview()
    keyboardHasShown()
    DrNoteTextView.text = HomeViewController.currentUser.note ?? "Tap edit to add notes here"
    print(HomeViewController.currentUser.note)
    navigationItem.rightBarButtonItem = editButtonItem
      
    scrollView.delegate = self
    scrollView.contentSize = CGSize(width:self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.view.safeAreaLayoutGuide.layoutFrame.height)
    scrollView.frame.size.height = view.safeAreaLayoutGuide.layoutFrame.height
  }
  
  private func addSubview() {
    noteViewContainer.addSubview(DrNoteTextView)
    scrollView.addSubview(titleLabel)
    scrollView.addSubview(noteViewContainer)
    view.addSubview(scrollView)
    addConstraints()
  }
  
  private func addConstraints() {
    
    scrollView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
      make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
      make.bottom.equalTo(0)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(scrollView.snp.top)
      make.centerX.equalTo(scrollView.snp.centerX)
      make.width.equalTo(view.frame.width - 150)
    }
    
    noteViewContainer.snp.makeConstraints{ make in
      make.centerX.equalTo(scrollView.snp.centerX)
      make.width.equalTo(view.frame.width - 60)
      make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.width)
      make.bottom.equalTo(scrollView.snp.bottom)
      make.top.equalTo(titleLabel.snp.bottom)
    }
    
    DrNoteTextView.snp.makeConstraints{ make in
      make.edges.equalTo(UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
    }
  }
  
  func keyboardHasShown(){
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHidden(_:)), name: UIResponder.keyboardDidHideNotification, object: nil )
  }
  
  @objc func keyboardWasShown(_ notification: NSNotification){
    
      guard let info = notification.userInfo, let keyboardFrameValue = info[ UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
      let keyboardFrame = keyboardFrameValue.cgRectValue
      let keyboardSize = keyboardFrame.size
      scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
    scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
  }
  
  @objc func keyboardWasHidden(_ notification: NotificationCenter){
    scrollView.contentInset = .zero
  }
}
