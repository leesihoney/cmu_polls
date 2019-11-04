//
//  Option.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct Option: Identifiable {
  var id: String
  var text: String
  var question_id: String
  
  init (id: String, text: String, question_id: String) {
    self.id = id
    self.text = text
    self.question_id = question_id
  }
}
