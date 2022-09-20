//  Image.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-25.
//

import Foundation
import UIKit

struct Image: Hashable {
  var id: Int
  var uiImage: UIImage
  var uuid = UUID().uuidString.lowercased()
    
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(uiImage)
  }
  
  static func == (lhs: Image, rhs: Image) -> Bool {
    return lhs.uuid == rhs.uuid
  }
  
}

