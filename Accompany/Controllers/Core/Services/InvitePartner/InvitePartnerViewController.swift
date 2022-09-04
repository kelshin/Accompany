////
////  InvitePartnerViewController.swift
////  Accompany
////
////  Created by Mark Wong on 2022-02-17.
////
//
//import UIKit
//
//class InvitePartnerViewController: UIViewController {
//  
//  let inviteTitle = TitleLabel(title: Services.invitePartner.description, size: .medium, color: .red)
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
//    
//    setupLayout()
//  }
//  
//  func setupLayout() {
//    view.addSubview(inviteTitle)
//    
//    inviteTitle.snp.makeConstraints { make in
//      make.top.equalTo(view.safeAreaLayoutGuide)
//      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
//      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
//    }
//  }
//
//}
