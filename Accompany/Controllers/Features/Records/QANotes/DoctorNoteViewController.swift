//
//  DoctorNoteViewController.swift
//  Accompany
//
//  Created by Kelbin David on 2022-02-17.
//

import UIKit
import SnapKit

class DoctorNoteViewController: UIViewController, UIScrollViewDelegate {

  var noteContent : String?
  
<<<<<<< HEAD:Accompany/Controllers/Core/Records/DoctorNoteViewController.swift
  let titleLabel = TitleLabel(title: "Q&A To Obstetrician", size: .medium)
=======
  let titleLabel = TitleLabel(title: "Q&A To\nObstetrician", size: .medium, color: .red)
  
//  let titleLabel : UILabel = {
//    let label = UILabel()
//    label.text = """
//                  Q&A To
//                  Obstetrician
//                """
//    label.font = UIFont(name: "SimpleBoy", size: 50)
//    label.textColor = #colorLiteral(red: 0.9926157594, green: 0.3876789808, blue: 0.5335384011, alpha: 1)
//    label.numberOfLines =
//    label.textAlignment = .center
//    label.setLineSpacing(lineSpacing: 1, lineHeightMultiple: 0.5)
//
//    return label
//  }()
>>>>>>> dev:Accompany/Controllers/Core/Records/QANotes/DoctorNoteViewController.swift
  
  let rightBarButton : UIButton = {
    let button = UIButton()
    button.setTitle("Edit", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    
    return button
  }()
  
  let DrNoteTextView : UITextView = {
    let textView = UITextView()
    textView.isUserInteractionEnabled = false
    textView.font = .boldSystemFont(ofSize: 18)
    
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
      DrNoteTextView.becomeFirstResponder()
    } else {
      noteContent = DrNoteTextView.text
    }
    DrNoteTextView.isUserInteractionEnabled.toggle()
  }
  
  
  let scrollView : UIScrollView = {
    let scrollView = UIScrollView()
    return scrollView
  }()
  
    override func viewDidLoad() {
<<<<<<< HEAD:Accompany/Controllers/Core/Records/DoctorNoteViewController.swift
      super.viewDidLoad()
      
      addSubview()
      keyboardHasShown()
=======
        super.viewDidLoad()
      view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
      
      addSubview()
      
      titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
      
>>>>>>> dev:Accompany/Controllers/Core/Records/QANotes/DoctorNoteViewController.swift
      DrNoteTextView.text = noteContent
      
      navigationItem.rightBarButtonItem = editButtonItem
      
      scrollView.delegate = self
      scrollView.contentSize = CGSize(width:self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.view.safeAreaLayoutGuide.layoutFrame.height) // set height according you
      scrollView.frame.size.height = view.safeAreaLayoutGuide.layoutFrame.height
      print(scrollView.frame.size.height)
      print(view.safeAreaLayoutGuide.layoutFrame.size.height)
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
      make.height.equalTo(view.safeAreaLayoutGuide.snp.height)
      make.width.equalTo(view.safeAreaLayoutGuide.snp.width)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(scrollView.snp.top)
      make.centerX.equalTo(scrollView.snp.centerX)
      make.width.equalTo(view.frame.width - 150)
    }
    
    noteViewContainer.snp.makeConstraints{ make in
      make.centerX.equalTo(scrollView.snp.centerX)
      make.width.equalTo(view.frame.width - 30)
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
    
<<<<<<< HEAD:Accompany/Controllers/Core/Records/DoctorNoteViewController.swift
      guard let info = notification.userInfo, let keyboardFrameValue = info[ UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
      let keyboardFrame = keyboardFrameValue.cgRectValue
      let keyboardSize = keyboardFrame.size
      scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
    scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
=======
    rightBarButton.snp.makeConstraints{ make in
      make.width.equalTo(40)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
>>>>>>> dev:Accompany/Controllers/Core/Records/QANotes/DoctorNoteViewController.swift
  }
  
  @objc func keyboardWasHidden(_ notification: NotificationCenter){
    scrollView.contentInset = .zero
  }
}
