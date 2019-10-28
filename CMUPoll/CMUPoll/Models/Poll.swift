//
//  Poll.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

struct Poll: Identifiable {
  var id = UUID()
  var user_id : Int
  var title : String
  var description: String
  var posted_at: Date
  var link: String
  var is_private: Bool
  var is_closed: Bool
}


