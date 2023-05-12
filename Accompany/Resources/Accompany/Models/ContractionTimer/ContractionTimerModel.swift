//
//  ContractionDetailsModel.swift
//  Accompany
//
//  Created by Esperanza on 2023-04-23.
//

import Foundation

// MARK: - Model

/// A model that we can use to view the user's contraction details.
struct ContractionDetailsModel: Codable {
  
  // MARK: - Properties
  
  /// A state that indicates the user's contraction state.
  public let state : String?
  
  /// A lenghth of each contraction.
  public let length : String?
}
