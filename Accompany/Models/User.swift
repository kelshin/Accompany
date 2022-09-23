//
//  ProfileOption.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-22.
//
import Foundation
import UIKit

struct Info : Codable {
  
  var username: String
  var email: String
  var babyName: String
  var dateOfPregnancy: String?
  var dueDate: Date?
  var statusMessage: String?
  var bio: String?
  
  static func loadSampleInfo() -> Info {
    return Info(username: "", email: "", babyName: "", dateOfPregnancy: nil, statusMessage: "", bio: "")
  }
}

struct User : Codable {
  
  var id: UUID?
  var info: Info?
  // TODO: add default todos
//  var todolists = [TodoList]()
  // TODO: Photos
//  var media: [URL]?
  var contractionRecord: [Contractions]?
  var note: String?
//  var isNotificationOn: Bool = false
}
