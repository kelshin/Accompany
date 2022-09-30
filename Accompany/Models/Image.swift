//  Image.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-25.
//

import Foundation
import UIKit

struct Image: Hashable {
//  var id: Int
  var uiImage: UIImage
  var uuid = UUID().uuidString.lowercased()
  
  func hash(into hasher: inout Hasher) {
//    hasher.combine(id)
    hasher.combine(uiImage)
  }
  
//  static func loadPhotoCell() -> [Image]? {
//    return nil
//  }
//
//  static func loadSampleSlide() -> [Image] {
//    var slideArr: [Image] = []
//
//    for i in 1...10 {
//      slideArr.append(Image(id: i, uiImage: UIImage(named: "logo-app")!))
//    }
//    return slideArr
//  }
  
//  static func loadSampleUpload() -> [Image] {
//    var uploadArr: [Image] = []
//    for i in 1...3 {
//      uploadArr.append(Image(id: i, uiImage: UIImage(named: "logo-app")!))
//    }
//    
//    return uploadArr
//  }
  
  static func == (lhs: Image, rhs: Image) -> Bool {
    return lhs.uuid == rhs.uuid
  }
  
}

