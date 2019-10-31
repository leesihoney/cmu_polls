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
  
  init (first: String, last: String, major: String, graduation: Int) {
    self.first_name = first
    self.last_name = last
    self.major = major
    self.graduation_year = graduation
  }
  
  
}


