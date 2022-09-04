//
//  TermsOfUseViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-17.
//

import UIKit

class TermsOfUseViewController: CustomTableController {

  override func viewDidLoad() {
    super.viewDidLoad()

    titleLabel.text = "Terms Of Use"
    
    configureTableView()
    contentTableView.dataSource = self
  
    setupLayout()
  }
  
}

extension TermsOfUseViewController: UITableViewDataSource {
 
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    contentCell.contentTextLabel.text = CellContent.termsOfUse.description
    return contentCell
  }
    
}
