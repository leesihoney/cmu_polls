//
//  PollTag.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct PollTag: Identifiable {
  var id: String
  var poll_id: String
  var tag_id: String
  
  init (id: String, poll_id: String, tag_id: String) {
    self.id = id
    self.poll_id = poll_id
    self.tag_id = tag_id
  }  
}
