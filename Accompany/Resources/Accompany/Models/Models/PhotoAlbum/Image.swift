//  Image.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-25.
//

import Foundation
import UIKit

// MARK: - Model

/// An image model that we use to create an image in the project.
struct Image: Hashable {
  
  // MARK: - Properties
  
  /// An UIImage type of an image.
  var uiImage: UIImage
  
  /// A property that provides a specific identification for each Image object.
  var uuid = UUID().uuidString.lowercased()
 
  // MARK: - Static Properties
  
  /// A property indicates that users save their data somewhere in their app's Documents directory.
  static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  
  /// A property that we use to create a subfolder for archiving data, and store that path to a constant.
  static let archieveURL = documentsDirectory.appendingPathComponent("")

  // MARK: - Private Methods
  
  /// A method is to allow an object to be used as a key in a hash-based collection by providing a hash value for the object.
  /// - Parameter hasher: A hash function that combines values into a single hash value.
  internal func hash(into hasher: inout Hasher) {
    hasher.combine(uiImage)
  }
 
  /// A method that we use compare if two Image objects are the same or not by their uuid property.
  /// - Parameters:
  ///   - lhs: A Image object.
  ///   - rhs: A Image object.
  /// - Returns: A boolean value.
  static func == (lhs: Image, rhs: Image) -> Bool {
    return lhs.uuid == rhs.uuid
  }
}
