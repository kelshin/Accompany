//
//  PrivacyPolicyViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-17.
//

import UIKit

class PrivacyPolicyViewController: CustomTableController {

  override func viewDidLoad() {
    super.viewDidLoad()

    titleLabel.text = AccountSettings.privacyPolicy.rawValue
    
    configureTableView()
    contentTableView.dataSource = self
    
    setupLayout()
    
  }
    
}

extension PrivacyPolicyViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    contentCell.contentTextLabel.text = CellContent.privacyPolicy.description
    return contentCell
  }
    
}
