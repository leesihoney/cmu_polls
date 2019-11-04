//
//  User.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct User: Identifiable {
  enum RewardType {
    case upload, answer, comment
  }
  var id: String
  var first_name: String
  var last_name: String
  var major: String
  var graduation_year: Int? = 2020
  var points: Int = 0
  
  init (id: String, first_name: String, last_name: String, major: String, graduation_year: Int?) {
    self.id = id
    self.first_name = first_name
    self.last_name = last_name
    self.major = major
    self.graduation_year = graduation_year
  }
  
  private func reward(type: RewardType) -> Int {
    switch type {
    case .upload:
      return 10
    case .answer:
      return 5
    case .comment:
      return 5
    }
  }
  
  mutating func addPoints(type: RewardType) {
    self.points += reward(type: type)
  }
  
  func createPoll() {
    return
  }
  
  mutating func countPoll() {
    let query = FirebaseDataHandler.colRef(collection: .poll).whereField("user_id", isEqualTo: id)
    FirebaseDataHandler.get(query: query, completion: { data in
      let instances = ModelParser.parse(collection: .poll, data: data)
      print(instances.count)
    })
  }
}
