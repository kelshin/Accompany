//
//  ContractionTimerModel.swift
//  Accompany
//
//  Created by Kelbin David on 2022-02-17.
//

import Foundation

/// A model that we use to create a contraction timer object.
struct ContractionTimerModel: Codable {
  
  // MARK: - Properties
  
  /// A date that we use for the contraction timer.
  public let contractionDate: Date?
  
  /// An array of contraction details.
  public var contractionRecord: [ContractionDetailsModel]?
}
