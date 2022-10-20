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
  
  static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  static let archieveURL = documentsDirectory.appendingPathComponent("")
  
  func hash(into hasher: inout Hasher) {
//    hasher.combine(id)
    hasher.combine(uiImage)
  }
  
  static func loadPhoto(url: URL) {
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, let newImage = UIImage(data: data) else {
        print("can't load image from url: \(url)")
        return
      }
      self.init(uiImage: newImage)
    }
    task.resume()
  }
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

