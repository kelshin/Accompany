//
//  UserModel.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-22.
//
import Foundation

/// A model we use to create an user object.
struct UserModel: Codable {
  
  // MARK: - Properties
  
  /// An id that we use to identify the user.
  public let id: UUID? = UUID()
  
  /// The details info of the user.
  public let detailsInfo: UserDetailsInfoModel?
  
  /// An array that contains the user's contraction times.
  public let contractionRecord: [ContractionTimerModel]?
  
  /// The note that the user writes in the To Do List view.
  public let note: String?
}
