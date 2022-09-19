//
//  ProfileOption.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-22.
//
import Foundation

struct Info {
  
  var username: String
  var email: String
  var babyName: String
  var dateOfPregnancy: String?
  var dueDate: Date?
  var statusMessage: String?
  var bio: String?
  
  static func loadSampleInfo() -> Info {
    return Info(username: "Accompany", email: "accompany@email.com", babyName: "Not decided yet", dateOfPregnancy: nil, dueDate: nil, statusMessage: "Happy Mom, Happy Baby!", bio: " Accompany is a pregnant app...")
  }
  
}

struct User {
  
//  var info: Info?
  // TODO: add default todos
  var todolists = [TodoList]()
  // TODO: Photos
//  var media: [URL]?
//  var contractions: [Contractions]
//  var note: String?
//  var isNotificationOn: Bool = false
}
