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
  var id = UUID()
  var first_name : String = ""
  var last_name: String = ""
  var major: String = ""
  var graduation_year: Int = 2020
  var points: Int = 0
  var documentId: String = "It is a document for model: User"
  
  init (first_name: String, last_name: String, major: String, graduation_year: Int, documentId: String) {
    self.first_name = first_name
    self.last_name = last_name
    self.major = major
    self.graduation_year = graduation_year
    self.documentId = documentId
  }
}
