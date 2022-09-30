//
//  Contraction.swift
//  Accompany
//
//  Created by Kelbin David on 2022-02-17.
//

import Foundation

struct Contractions {
  let contractionDate: Date?
  var contractionRecord: [Detail]?
}

struct Detail {
  let state : String?
  let length : String?
}
