//
//  Contraction.swift
//  Accompany
//
//  Created by Kelbin David on 2022-02-17.
//

import Foundation

struct Contractions : Codable {
  let contractionDate: Date?
  var contractionRecord: [Detail]?
}

struct Detail : Codable {
  let state : String?
  let length : String?
}
