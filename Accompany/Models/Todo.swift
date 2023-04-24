//
//  Todo.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-16.
//

import Foundation

struct Todo: Codable {
  
  static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
  
  var id = UUID()
  var title: String
  var isCompleted: Bool = false
  var note: String? = "Type your notes here."
}
  
