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
  var name: String?
  var babyName: String
  var dateOfPregnancy: String?
  var dueDate: Date?
  var statusMessage: String?
  var bio: String?
  
  static func loadSampleInfo() -> Info {
    return Info(username: "", name: "", babyName: "", dateOfPregnancy: nil, statusMessage: "", bio: "")
  }
}

struct User : Codable {
  
  var id: UUID?
  var info: Info?
  // TODO: implement todolist in user data
//  var todolists = [TodoList]()
  // TODO: implement photos in user data
//  var media: [URL]?
  var contractionRecord: [Contractions]?
  var note: String?
//  var isNotificationOn: Bool = false
}
