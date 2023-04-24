//
//  UserDetailsInfoModel.swift
//  Accompany
//
//  Created by Esperanza on 2023-04-23.
//

import Foundation

// A model we used to create a details info of the user object.
struct UserDetailsInfoModel: Codable {
  
  // MARK: - Properties

  /// The name of the user.
  public let name: String?
  
  /// The name of the baby.
  public let babyName: String?
  
  /// The date when the user's baby is due to be born.
  public let dueDate: Date?
  
  /// The message that the user types.
  public let statusMessage: String?
  
  /// A brief introduction of the user.
  public let intro: String?
 
  
  // MARK: - Methods
  
  /// A fucntion that we use to load data.
  /// - Returns: An user details info model.
  public static func loadSampleInfo() -> UserDetailsInfoModel {
    UserDetailsInfoModel(name: "", babyName: "", dueDate: nil, statusMessage: "", intro: "")
  }
}
