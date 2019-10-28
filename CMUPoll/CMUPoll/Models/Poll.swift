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
  var user_id : UUID
  var title : String = ""
  var description: String = ""
  var posted_at: Date = Date()
  var link: String = ""
  var is_private: Bool = false
  var is_closed: Bool = false
  
  init (user_id: UUID, title: String, descrip: String, posted: Date, link: String, is_priv: Bool, is_clos: Bool) {
    self.user_id = user_id
    self.title = title
    self.description = descrip
    self.posted_at = posted
    self.link = link
    self.is_private = is_priv
    self.is_closed = is_clos
  }
}


