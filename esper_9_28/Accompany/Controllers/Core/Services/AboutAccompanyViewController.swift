//
//  AboutAccompanyViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-17.
//

import UIKit

class AboutAccompanyViewController: CustomTableController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    titleLabel.text = Services.aboutAccompany.description
    
    configureTableView()
    contentTableView.dataSource = self
    setupLayout()
    
  }

}

extension AboutAccompanyViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    contentCell.contentTextLabel.text = CellContent.aboutAccompany.description
    return contentCell
  }
    
}
