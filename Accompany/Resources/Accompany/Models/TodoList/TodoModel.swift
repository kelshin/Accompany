//
//  Todo.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-16.
//

import Foundation

// MARK: - Model

/// A model that we use to create a todo obejct, which is displayed on a todo list.
struct Todo: Codable {
  
  // MARK: - Properties
  
  /// A property that provides a specific identification for each todo object.
  var id = UUID()
  
  /// A tile of todo.
  var title: String
  
  /// A property that shows if this todo is completed or not.
  var isCompleted: Bool = false
  
  /// A property that displays the notes for a to-do item and has a default value of 'Type your notes here.
  var note: String? = "Type your notes here."
  
  // MARK: - Static Properties
  
  /// A property indicates that users save their data somewhere in their app's Documents directory.
  static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  
  /// A property that we use to create a subfolder for archiving data, and store that path to a constant.
  static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
}
