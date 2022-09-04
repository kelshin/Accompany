//
//  RecordsViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit
import SnapKit

class RecordsViewController: UIViewController {
  
  let recordLabel = TitleLabel(title: "Record While\nPregnancy", size: .medium, color: .red)
  
  let goToAlbumButton = SecondaryButton(title: "Photo Album")
  let goToTimerButton = PrimaryButton(title: "Contraction Timer")
  let goToQAButton = PrimaryButton(title: "Q&A To Obstetrician")
  
  let bgCircleView = ImageView()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    bgCircleView.image = UIImage(named: "grey-bg")
    
    setupLayout()
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Record", style: .plain, target: nil, action: nil)
    
  }
  
  private func setupLayout() {
    
    view.addSubview(recordLabel)
    recordLabel.lineBreakMode = NSLineBreakMode.byWordWrapping

    recordLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    
    view.addSubview(bgCircleView)
    
    bgCircleView.snp.makeConstraints { make in
      make.top.equalTo(recordLabel.snp.bottom).offset(40)
      make.centerX.equalTo(view)
      make.left.equalTo(view.safeAreaLayoutGuide)
      make.right.equalTo(view.safeAreaLayoutGuide)
    }
    
    let buttons = [goToAlbumButton, goToTimerButton, goToQAButton]
    buttons.forEach { $0.addTarget(self, action: #selector(goTo(_:)), for: .touchUpInside) }
    
    let vStack = VStack(arrangedSubviews: buttons)
    view.addSubview(vStack)
    
    vStack.spacing = 45
  
    vStack.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.55)
      make.top.equalTo(bgCircleView.snp.top).offset(70)
    }
 
  }
  
  @objc func goTo(_ button: UIButton) {
    
    switch button {
    case goToAlbumButton:
      let babyVC = BabySonogramController()
      navigationController?.pushViewController(babyVC, animated: true)
    case goToTimerButton:
      let timerVC = ContractionTimerViewController()
      navigationController?.pushViewController(timerVC, animated: true)
    case goToQAButton:
      // MARK: Need to be adjusted
      let qaVC = QAController()
      navigationController?.pushViewController(qaVC, animated: true)
      
    default:
      return
    }

  }
  
}

