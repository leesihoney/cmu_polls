//
//  Comment.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct Comment: Identifiable {
  var id = UUID()
  var content: String
  var posted_at: Date
  var user_id: UUID
  var comment_id: UUID
  var poll_id: UUID
}


