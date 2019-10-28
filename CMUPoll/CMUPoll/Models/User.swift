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
  var first_name : String
  var last_name: String
  var major: String
  var graduation_year: Int
  var points: Int
}


