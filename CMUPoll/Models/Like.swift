//
//  Like.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct Like: Identifiable {
  var id: String
  var user_id: String
  var poll_id: String
  
  init (id: String, user_id: String, poll_id: String) {
    self.id = id
    self.user_id = user_id
    self.poll_id = poll_id
  }
}
