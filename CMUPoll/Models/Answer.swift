//
//  Answer.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct Answer: Identifiable {
  var id: String
  var user_id: String
  var question_id: String
  var option_id: String
  
  init (id: String, user_id: String, question_id: String, option_id: String) {
    self.id = id
    self.user_id = user_id
    self.question_id = question_id
    self.option_id = option_id
  }
}
